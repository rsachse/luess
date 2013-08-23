#' Estimation of Ecosystem Services from LPJmL Model Output
#'
#' Collection of methods to derive quantification of ecosystem services
#' from LPJmL model output.
#'
#' @docType package
#' @name luess
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#' @aliases luess luess-package
NULL
#' Nutritional composition and dry weight of crop functional types
#' 
#' The data set provides kcal per g WW, g protein per g WW, g fat 
#' per g WW and DW/WW [\%] for the 16 crop functional types.
#'
#' @name cft_nutrients
#' @docType data
#' @references See FAO (2001) and \url{http://www.fao.org/docrep/003/x9892e/X9892e05.htm#P8217_125315} 
#' for kcal, proteins and fat; Wirsenius (2000) for dry weights.
#' 
#' Food and Agriculture Organization of the United Nations, Rome, 2001. 
#' FOOD BALANCE SHEETS. A handbook.
#' 
#' Wirsenius, S., 2000. Human use of Land and Organic Materials: Modeling the
#' Turnover of Biomass in the Global Food System. Dept. of Physical Resource
#' Theory, Chalmers University of Technology and Goeteborg University, Goeteborg.
#' @keywords data, nutrients, dry weight, crop functional types
NULL
#' Coordinates of LPJmL output grid cells 
#' 
#' The data provides coordinates of LPJmL output grid cells.
#' It includes 59199 land cells of an older LPJmL version which had
#' a reduced number of output cells due to no soil information for some cells.
#'
#' @name lpj_short_outgrid
#' @docType data
#' @keywords LPJmL, grid cells, grid 
NULL
#' Positions of LPJmL output grid cells in the input grid
#' 
#' The data provides positions of LPJmL output grid cells within the input grid used for 
#' CLUMondo coupling. It includes 59199 land cells of an older LPJmL version which had
#' a reduced number of output cells due to no soil information for some cells.
#'
#' @name lpj_short_clupos
#' @docType data
#' @keywords LPJmL, grid cells, grid, CLUMondo 
NULL
#' Assignment of CLUMondo Land Use Systems to LPJmL Grid Cells for the year 2040
#' 
#' The data includes assignments of CLUMondoy Land Use Systems of the year 2040 
#' to the old LPJmL grid, containing 59199 cells.
#'
#' @name CLUtoLPJ2040
#' @docType data
#' @references A full documentation of the data can be found in: 
#' Van Asselen, S., Verburg, P.H. (2012) A Land System representation 
#' for global assessments and land-use modeling. Global Change Biology. 
#' DOI: 10.1111/j.1365-2486.2012.02759.x.
#' 
#' @keywords LPJmL, grid cells, grid, CLUMondo 
NULL