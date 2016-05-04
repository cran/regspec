\name{regspec-package}
\alias{regspec-package}
\docType{package}
\title{
Non-parametric multirate spectral density estimation via linear Bayes.
}
\description{Estimate a spectral density function of a stationary time
	series. Produces a linear Bayes estimate with credible intervals.
	Can incorporate time series data from multiple realizations with
	different sampling rate. Can deal with time series data that has
	been filtered with a known filter (e.g. quarterly totals from monthly
	values).
}
\details{
\tabular{ll}{
Package: \tab regspec\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2014-04-22\cr
License: \tab MIT\cr
}
Currently, the package's centrepiece is the function \code{\link{regspec}}, which implements spectral density estimation from time series data at integer time points.
A novel element of the code is it's ability to assimilate subsampled and filter data.

The package's data files, which will be loaded automatically, include synthetic and real examples of time series data that feature in the \code{Examples} sections of the functions' help files.
}
\author{
Ben Powell
}
\references{
Nason, G.P., Powell, B., Elliott, D. and Smith, P. (2016) 
	Should We Sample a Time Series More Frequently? Decision Support
	via Multirate Spectrum Estimation.
	Journal of the Royal Statistical Society, Series A., 179,
	(to appear).
}
\keyword{ package }
\keyword{ ts }
\keyword{ smooth }
\seealso{
\code{\link{regspec}}
}
