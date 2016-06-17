# This config file is largely adapted from
# http://www.r-bloggers.com/fun-with-rprofile-and-customizing-r-startup/

suppressMessages(require(magrittr))

# Quit without saving the stupid ennvironment
q <- function (save="no", ...) {
  quit(save=save, ...)
}

# Turn off those annoying popups
options(menu.graphics=FALSE)

# # Stop the madness
# # I comment this out to avoid portability issues
# options(stringsAsFactors=FALSE)

# Max number of lines to print
options(max.print=100)

# Allow autocomplate of package names in library or require
utils::rc.settings(ipck=TRUE)

# Save history
.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.RHistory"
    savehistory(hist_file)
  }
}

# Suppress messages
sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}

# Allow colors, if appropriate
if(Sys.getenv("TERM") %in% c("xterm-256color", "screen-256color")){
  # library(devools) 
  # install_github('jalvesaq/colorout')
  suppressMessages(require(colorout))
  setOutputColors(stderror=2, verbose=FALSE)
  invisible()
}
