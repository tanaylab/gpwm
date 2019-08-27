.onLoad <- function(libname, pkgname) {
    if (!exists('.gpwm_cache__', envir=globalenv())) {
        .gpwm_cache__ <<- new.env()
    }   
}
