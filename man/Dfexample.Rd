\name{Synthetic example data}
\alias{Dfexample}\alias{Dpexample2}\alias{Dpexample3}\alias{spec.true}
\docType{data}
\title{
Synthetic Data for Testing Functions in the regspec Package.
}
\description{
\code{spec.true} is a matrix of coordinates for the spectral density of the
ARMA(3,1) model with AR and MA coefficients (-0.5, 0.4, 0.8) and (0.2)
respectively. This was the model used to simulate the example data sets
\code{Dfexample}, \code{Dpexample2} and \code{Dpexample3},
which consist of observations of the process at every time point,
at every second time point and every third time point, respectively.
}
\details{
See the package \code{TSA} for functions to calculate values of the spectral density for different ARMA models, and the function \code{arima.sim} for simulating time series from them.
}
\references{
Nason, G.P., Powell, B., Elliott, D. and Smith, P. (2016) 
	Should We Sample a Time Series More Frequently? Decision Support
	via Multirate Spectrum Estimation.
	Journal of the Royal Statistical Society, Series A., 179,
	(to appear).
}
\keyword{datasets}
