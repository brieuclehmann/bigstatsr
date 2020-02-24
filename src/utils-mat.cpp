/******************************************************************************/

#include <bigstatsr/BMAcc.h>

using namespace Rcpp;
using std::size_t;

/******************************************************************************/

// [[Rcpp::export]]
const char* const GET_ERROR_DIM() {
  return ERROR_DIM;
}

/******************************************************************************/

// [[Rcpp::export]]
NumericMatrix& centering(NumericMatrix& source,
                         const NumericVector& mean) {

  size_t n = source.rows();
  size_t m = source.cols();
  size_t i, j;

  for (j = 0; j < m; j++)
    for (i = 0; i < n; i++)
      source(i, j) -= mean[j];

  return source;
}

/******************************************************************************/

// For a square FBM
// [[Rcpp::export]]
void scaleK(Environment BM,
            const NumericVector& sums,
            const NumericVector& mu,
            const NumericVector& delta,
            int nrow) {

  XPtr<FBM_RW> xpBM = BM["address_rw"];
  BMAcc_RW<double> K(xpBM);

  size_t n = K.nrow();
  myassert_size(K.ncol(), n);

  for (size_t j = 0; j < n; j++) {
    for (size_t i = 0; i < n; i++) {
      K(i, j) -= sums[i] * mu[j] + mu[i] * sums[j];
      K(i, j) += nrow * mu[i] * mu[j];
      K(i, j) /= delta(i) * delta(j);
    }
  }
}

/******************************************************************************/
