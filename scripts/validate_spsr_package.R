args <- commandArgs(trailingOnly = TRUE)

usage <- function(status = 0) {
  lines <- c(
    "Usage:",
    "  Rscript scripts/validate_spsr_package.R <package-path> [--require-iris] [--metasalmon-source <path>]",
    "",
    "Runs metasalmon::validate_salmon_datapackage() against a local Salmon Data Package.",
    "",
    "Examples:",
    "  Rscript scripts/validate_spsr_package.R path/to/my-salmon-data-package",
    "  Rscript scripts/validate_spsr_package.R path/to/my-salmon-data-package --require-iris",
    "  Rscript scripts/validate_spsr_package.R path/to/my-salmon-data-package --metasalmon-source ../metasalmon",
    "",
    "Optional environment variable:",
    "  METASALMON_SOURCE=/path/to/metasalmon"
  )
  cat(paste(lines, collapse = "\n"), "\n")
  quit(save = "no", status = status)
}

script_path <- function() {
  file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  if (length(file_arg) == 0) {
    return(NA_character_)
  }

  normalizePath(sub("^--file=", "", file_arg[[1]]), winslash = "/", mustWork = FALSE)
}

ancestor_dirs <- function(path, max_depth = 8) {
  if (is.na(path) || !nzchar(path)) {
    return(character())
  }

  current <- normalizePath(path, winslash = "/", mustWork = FALSE)
  out <- character()

  for (i in seq_len(max_depth)) {
    out <- c(out, current)
    parent <- dirname(current)
    if (identical(parent, current)) {
      break
    }
    current <- parent
  }

  unique(out)
}

find_local_metasalmon_source <- function() {
  candidates <- character()

  env_source <- Sys.getenv("METASALMON_SOURCE", unset = "")
  if (nzchar(env_source)) {
    candidates <- c(candidates, env_source)
  }

  starts <- c(getwd())
  path <- script_path()
  if (!is.na(path)) {
    repo_root <- normalizePath(file.path(dirname(path), ".."), winslash = "/", mustWork = FALSE)
    starts <- c(starts, repo_root)
  }

  starts <- unique(starts[nzchar(starts)])

  for (start in starts) {
    for (dir in ancestor_dirs(start)) {
      candidates <- c(
        candidates,
        file.path(dir, "metasalmon"),
        file.path(dir, "code", "metasalmon")
      )
    }
  }

  candidates <- unique(normalizePath(candidates, winslash = "/", mustWork = FALSE))
  existing <- candidates[dir.exists(candidates)]

  if (length(existing) > 0) {
    return(existing[[1]])
  }

  if (length(candidates) > 0) {
    return(candidates[[1]])
  }

  NA_character_
}

installed_metasalmon_version <- function() {
  if (!requireNamespace("utils", quietly = TRUE)) {
    return(NULL)
  }

  tryCatch(utils::packageVersion("metasalmon"), error = function(e) NULL)
}

load_validator <- function(source_path) {
  min_version <- numeric_version("0.0.20")
  installed_version <- installed_metasalmon_version()

  if (!is.null(installed_version) && installed_version >= min_version) {
    suppressPackageStartupMessages(library(metasalmon))
    message(sprintf("Using installed metasalmon %s", as.character(installed_version)))
    return(metasalmon::validate_salmon_datapackage)
  }

  if (!is.na(source_path) && dir.exists(source_path)) {
    if (!requireNamespace("pkgload", quietly = TRUE)) {
      stop(
        "Found a local metasalmon checkout at ", source_path,
        ", but pkgload is not installed. Install pkgload or metasalmon >= 0.0.20.",
        call. = FALSE
      )
    }

    suppressPackageStartupMessages(pkgload::load_all(source_path, quiet = TRUE))
    message(sprintf("Using local metasalmon checkout at %s", normalizePath(source_path, winslash = "/")))
    return(get("validate_salmon_datapackage", envir = asNamespace("metasalmon"), inherits = FALSE))
  }

  installed_text <- if (is.null(installed_version)) {
    "not installed"
  } else {
    paste0("installed version ", as.character(installed_version))
  }

  source_hint <- if (is.na(source_path)) {
    "No local metasalmon checkout was detected automatically."
  } else {
    paste0("Auto-detected source path was ", source_path, ", but it does not exist.")
  }

  stop(
    paste0(
      "This helper needs metasalmon >= 0.0.20 so it can call validate_salmon_datapackage(). ",
      "Current state: ", installed_text, ". ",
      source_hint, " ",
      "Either install a newer metasalmon build, set METASALMON_SOURCE, or pass --metasalmon-source /path/to/metasalmon."
    ),
    call. = FALSE
  )
}

if (length(args) == 0 || any(args %in% c("-h", "--help"))) {
  usage()
}

require_iris <- FALSE
metasalmon_source <- find_local_metasalmon_source()
package_path <- NULL

i <- 1
while (i <= length(args)) {
  arg <- args[[i]]

  if (identical(arg, "--require-iris")) {
    require_iris <- TRUE
  } else if (identical(arg, "--metasalmon-source")) {
    if (i == length(args)) {
      stop("--metasalmon-source needs a path.", call. = FALSE)
    }
    i <- i + 1
    metasalmon_source <- args[[i]]
  } else if (startsWith(arg, "--")) {
    stop(sprintf("Unknown flag: %s", arg), call. = FALSE)
  } else if (is.null(package_path)) {
    package_path <- arg
  } else {
    stop(sprintf("Unexpected extra argument: %s", arg), call. = FALSE)
  }

  i <- i + 1
}

if (is.null(package_path)) {
  usage(status = 1)
}

package_path <- normalizePath(package_path, winslash = "/", mustWork = TRUE)
metasalmon_source <- normalizePath(metasalmon_source, winslash = "/", mustWork = FALSE)
validator <- load_validator(metasalmon_source)

message(sprintf("Validating package: %s", package_path))
message(sprintf("require_iris = %s", require_iris))

tryCatch(
  {
    validator(package_path, require_iris = require_iris)
    message("Pre-flight validation finished successfully.")
  },
  error = function(e) {
    message("Pre-flight validation failed.")
    stop(conditionMessage(e), call. = FALSE)
  }
)
