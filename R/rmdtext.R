## This app requires OpenCPU 1.0.1 or higher !!!!
##

#' @export
#'
rmdtext <- function(){
 # writeLines(text, con="input.Rmd");
  knitr::knit2html("input.Rmd", output="output.html");
  invisible();
}

