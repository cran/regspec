\name{basis}
\alias{basis}
\title{
Basis maker.
}
\description{
A function for making matrices of sinusoidal basis function values.
}
\usage{
basis(x, nb)
}
\arguments{
  \item{x}{
The frequencies at which to evaluate the basis functions.
}
  \item{nb}{
The number of basis functions to include.
}
}
\value{
A matrix whose rows correspond to input values and whose columns correspond
to particular basis functions.
}
\author{
Ben Powell
}
\examples{
bas.mat<-basis(seq(0,0.5,length=16),22)
}
