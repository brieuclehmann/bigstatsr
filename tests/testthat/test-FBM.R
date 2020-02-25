context("FBM")

test_that("Methods for 'FBM' work", {

  X <- FBM(2, 2, init = 1)
  expect_equal(dim(X), c(2, 2))
  expect_length(X, 4)

  expect_equal(X[1], 1)
  X[4] <- 0
  expect_equal(X[4], 0)
  expect_equal(diag(X), c(1, 0))

  expect_equal(typeof(X), "double")
  expect_equal(typeof(FBM.code256(2, 2)), "unsigned char")

  cl <- parallel::makeCluster(1)
  parallel::clusterExport(cl, "X", envir = environment())
  type <- parallel::clusterEvalQ(cl, typeof(X))[[1]]
  expect_equal(type, "S4")  # (because rmio is not attached) how to change this?
})
