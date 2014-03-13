#' @title Determine Pixels within a certain range
#'
#' @description The function calculates which pixels are in a certain range. The function is written
#' in FORTRAN90 to speed up this time consuming step. However, the calculations are only speed up by 20% 
#' and it only works for a fixed vector length of 67420.
#'
#' @param coor numeric, vector of 2 providing the x- and y-coordinate
#' @param vecA numeric, vector of x-coordinates of all pixels
#' @param vecB numeric, vector of y-coordinates of all pixels
#' @param range numeric, range of the window
#' @return the function returns a vector of all pixel-IDs which are within the specified rectangular range
#' @examples 
#' idOld <- getNearPoints(coordinates(lpjGrid)[2000,], coordinates(lpjGrid), 2.5)
#' idNew <- whichLPJmL(coordinates(lpjGrid)[2000,], coordinates(lpjGrid)[,1], coordinates(lpjGrid)[,2], 2.5)
#' identical(idOld, idNew)
#' 
#' system.time({
#'   for(i in 1:100) idOld <- getNearPoints(coordinates(lpjGrid)[2000,], coordinates(lpjGrid), 2.5)
#' })
#' 
#' system.time({
#'   for(i in 1:100) idNew <- whichLPJmL(coordinates(lpjGrid)[2000,], coordinates(lpjGrid)[,1], coordinates(lpjGrid)[,2], 2.5)
#' })
whichLPJmL <- function(coor, vecA, vecB, range){
  xCor <- coor[1]
  yCor <- coor[2]
  vecLength <- length(vecA)
  ret <- .Fortran(
    "fastWhich", 
    xCor       = as.double(xCor),
    yCor       = as.double(yCor),
    vecA       = as.double(vecA),
    vecB       = as.double(vecB),
    range      = as.double(range),
    vecResult  = logical(vecLength)
  )
  ids <- 1:vecLength
  id  <- ids[ret$vecResult]
  return(id)
}

