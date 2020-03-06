library(bigsnpr)

celiac <- snp_attach("../Dubois2010_data/FinnuncorrNLITUK1UK3hap300_QC_norel.rds")
G <- celiac$genotypes$copy(code = c(0, 1, 2, 0, rep(NA, 252)))
rows <- rep(rows_along(G), each = 2)
cols <- rep(cols_along(G), each = 2)

Rcpp::sourceCpp('src/prodMatVec.cpp')
system.time(
  rowsums <- pMatVec4(G, rep(1, length(cols)), rows, cols, ncores = 4)
)
# 10.7 sec -> with OpenMP: 10.2 and 3.2
# 13.8 sec without unrolling optim
str(rowsums) # 300390 300390 300244 300244 299072

system.time(
  colsums <- cpMatVec4(G, rep(1, length(rows)), rows, cols, ncores = 4)
)
# 11 sec to 3.6 sec with 4 cores

system.time(
  obj.svd <- big_randomSVD(G, big_scale(), ncores = 4)
)
# Old: 249 sec -> 118 sec with 4 cores
# New: 255 sec -> 111 sec with 4 cores

system.time(
  test <- big_colstats(G, rows, cols, ncores = 4)
) # 18 sec -> 5 sec with 4 cores
head(test)
#     sum       var
# 1  9780 0.2737249
# 2  9780 0.2737249
# 3 16764 0.4010718
# 4 16764 0.4010718
# 5 10090 0.2780397
# 6 10090 0.2780397
