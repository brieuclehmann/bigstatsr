################################################################################

# Global variables
globalVariables(c("ic", "mods", "k", "loss_index", "set"))

################################################################################

#' @importFrom rmio sub_bk
#' @export
rmio::sub_bk

################################################################################

#' Numeric matrix from data frame
#'
#' Transform a data frame to a numeric matrix by one-hot encoding factors.
#' The last factor value is always omitted to prevent having a singular matrix
#' when adding a column of 1s (intercept) in models.
#'
#' @param df A data frame.
#'
#' @return A numeric matrix.
#' @export
#'
#' @examples
#' mat <- covar_from_df(iris)
#' head(mat)
covar_from_df <- function(df) {

  assert_class(df, "data.frame")

  if (is.null(names(df))) names(df) <- paste0("V", seq_along(df))

  stats::model.matrix(~ ., data = df)[, -1, drop = FALSE]
}

################################################################################
