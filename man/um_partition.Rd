% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/um-partition.r
\name{um_partition}
\alias{um_partition}
\title{Check whether partitions of the figuration matrix are unimodular}
\usage{
um_partition(A)
}
\arguments{
\item{A}{Configuration matrix with ncol(A) >= nrow(A)}
}
\value{
A list comprising a table of determinants and the number of rows (n) and columns (r) of the matrix A
}
\description{
Check whether partitions of the figuration matrix are unimodular. For partitions A=\link{A1 A2}, the function um_partition computes the determinants of A1 for all possible (unique) combinations of rows. Function um_partition_sample coputes determinants of A1 for a sample of those partitions.
}
\examples{
data(YangNetwork)
set.seed(2020)
um_partition_sample(YangNetwork$A)
}
