# This config file is largely adapted from
# http://www.r-bloggers.com/fun-with-rprofile-and-customizing-r-startup/

suppressMessages(require(magrittr))
suppressMessages(require(devtools))
suppressMessages(require(pryr))

# Quit without saving the stupid ennvironment
q <- function (save="no", ...) {
  quit(save=save, ...)
}

options(error=utils::dump.frames)
options(show.error.locations=TRUE)

# # set all available warnings
# options(check.bounds=TRUE)
# options(warnPartialMatchArgs=TRUE)
# options(warnPartialMatchAttr=TRUE)
# options(warnPartialMatchDollar=TRUE)

# Turn off those annoying popups
options(menu.graphics=FALSE)

# Max number of lines to print
options(max.print=1000)

# Allow autocomplate of package names in library or require
utils::rc.settings(ipck=TRUE)

# Suppress messages
sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}

# Allow colors, if appropriate
if(Sys.getenv("TERM") %in% c("xterm-256color", "screen-256color")){
  # library(devtools) 
  # install_github('jalvesaq/colorout')
  suppressMessages(require(colorout))
  setOutputColors(stderror=2, verbose=FALSE)
}

fs <- function(){
  # set the width of the output to the width of the window
  options(width=as.integer(Sys.getenv("COLUMNS")))
}

# Save history
.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.RHistory"
    savehistory(hist_file)
  }
}

