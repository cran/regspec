\name{hindcast}
\alias{hindcast}
\title{
Interpolate process values from a set of data, and an expectation and
variance specification for the process's log spectrum.
}
\description{
This function computes an approximate expectation for a
(second-order stationary) process's autocovariance function from the first
two moments of its log-spectrum, as encoded in an expectation vector and
variance matrix for the coefficients of a basis representation.
It then uses this autocovariance to interpolate values of a process
and to calculate variances for them.

The function is really here to facilitate the reproduction of an example
from Nason, Powell, Elliott and Smith (2016).
It may be studied as an example, but is not recommended for general use.
Instead, custom Kriging-type estimates ought to be produced by manipulating by
hand variance matrices populated with autocovariance function values,
which can be computed with the function \code{logspec2cov}.
}
\usage{
hindcast(Dhigh, hightimes, Dlow, lowtimes, predtimes, filter=c(1),
    ebeta, vbeta, SARIMA)
}
\arguments{
\item{Dhigh}{Vector. The high frequency data.}
\item{hightimes}{Vector. Integer time points at which the high frequency observations are made.}
\item{Dlow}{Vector. The low frequency data.}
\item{lowtimes}{Vector. Integer time points at which the low frequency observations are made.}
\item{predtimes}{Vector. Integer time points at which hindcasts are required.}
\item{filter}{Vector. A known vector of filter coefficients arising from the
    observation process prior to any subsampling.
    The default is \code{NULL}, which corresponds to direct observation and
    a filter vector of \code{(1,0,0,...)}.
    If the data are produced by taking a linear combination of the current
    and previous process values, for example, one would set this vector
    to be \code{(w_{t},w_{t-1})}.}
\item{ebeta}{
Vector. Expectations for basis coefficients of the log spectrum.
}
\item{vbeta}{
Vector. The variance for the basis coefficients of the log spectrum.
}
\item{SARIMA}{List. A list encoding the SARIMA model that acts as an intercept,
    or base line, for the non-parametric estimate of the log-spectrum.
    The default is white noise with variance one.
    The log-spectrum basis coefficients parameterize a deviation away
    from the SARIMA model's log-spectrum.
    The contents of the SARIMA list are formatted in line with the
    format used by the package \code{TSA}
    (see the \code{Examples} section for examples).}
}
\value{
\item{hindcast}{A vector of hindcast expectations}
\item{var.hindcast}{A covariance matrix for the hindcast values.}
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
\examples{
#
# See example in \code{\link{travel}} help file
#
}
