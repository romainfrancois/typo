#' install package from CRAN with typo suggestions
#'
#' Attempts to install a package from CRAN, and suggests alternatives
#' if it not available
#' @param package Name of the package to install
#' @param max_distance maximum distance. See \code{\link[stringdist]{stringdist}}
#' @param \dots Passed to \code{\link[utils]{install.packages}}
#'
#' @return nothing
#' @examples
#' \dontrun{
#'   cran_install( "dlpyr" )
#'   cran_install( "google" )
#' }
#' @importFrom utils install.packages available.packages
#' @importFrom stringdist stringdist
#' @importFrom tibble data_frame
#' @importFrom dplyr filter arrange
#' @importFrom magrittr %>%
#' @export
cran_install <- function(package, max_distance = 3, ...){
  attempt <- tryCatch( install.packages(package, ...), error = function(e) e, warning = function(w) w)

  if( ! is.null(attempt) ){
    message( sprintf( "package '%s' not found on CRAN. Here are some suggestions: ", package) )

    # try approximate matches
    packages <- rownames(available.packages())
    distances <- stringdist( package, packages )
    data <- data_frame( packages = packages, dist = distances )

    matches <- data %>%
      filter( dist < max_distance ) %>%
      arrange( dist )
    if( nrow(matches) ){
      message( "\nApproximate matches: \n", paste( matches$packages, collapse = ", ") )
    } else {
      message( "\nNo approximate matches with max_distance = ", max_distance )
    }

    # packages that contain the name
    matches <- agrep( package, packages )
    if( length(matches) ){
      message( "\nfuzzy (agrep) matches: \n", paste( packages[matches], collapse = ", ") )
    } else{
      message( "\nno fuzzy (agrep) matches. " )
    }
  }
  invisible(NULL)
}
