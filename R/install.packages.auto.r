#' instal packages automatically
#'
#' This function will automatically install and library/load the package when invoked.
#' It is a quick wrapper of of the install.package and biocoductor bioLite.
#' It also does not need quote on the package name.
#'
#' This function is just for quick and easy install and library usage. It does not consider installation from github yet.
#' If the pacakge has already been installed, no installation will be proceeded.
#'
#' @param x package name, with or without the quote both works
#'
#' @return None The same as intall.packages
#
#' @seealso \code{\link{install.packages}}
#'
#' @examples
#' install.packages.auto(roxygen2) # from CRAN
#' install.packages.auto(qvalue) # from bioconductor

#' @export

install.packages.auto <- function(x) {
  # setting up the miror
  local({
    r <- getOption("repos")
    r["CRAN"] <- "https://cloud.r-project.org/"
    options(repos = r)
  })


  x <- as.character(substitute(x))

  if(isTRUE(x %in% .packages(all.available=TRUE))) {
    eval(parse(text = sprintf("require(\"%s\")", x)))
  } else {
    update.packages(ask= FALSE) #update installed packages.
    eval(parse(text = sprintf("install.packages(\"%s\", dependencies = TRUE)", x)))
  }
  if(isTRUE(x %in% .packages(all.available=TRUE))) {
    eval(parse(text = sprintf("require(\"%s\")", x)))
  } else {
    source("http://bioconductor.org/biocLite.R")
    biocLite(character(), ask=FALSE) #update installed packages.
    eval(parse(text = sprintf("biocLite(\"%s\")", x)))
    eval(parse(text = sprintf("require(\"%s\")", x)))
  }
}
