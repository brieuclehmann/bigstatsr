################################################################################

CutBySize <- function(m, block.size, nb = ceiling(m / block.size)) {
  bigparallelr::split_len(m, nb_split = nb)
}

seq2 <- bigparallelr::seq_range

#' @importFrom bigparallelr rows_along
#' @export
bigparallelr::rows_along

#' @importFrom bigparallelr cols_along
#' @export
bigparallelr::cols_along

################################################################################

#' @importFrom bigparallelr nb_cores
#' @export
bigparallelr::nb_cores

#' @importFrom bigparallelr plus
#' @export
bigparallelr::plus

################################################################################

#' @importFrom rmio big_parallelize
#' @export
rmio::big_parallelize

#' @importFrom rmio big_apply
#' @export
rmio::big_apply

#' @importFrom rmio block_size
#' @export
rmio::block_size

################################################################################
