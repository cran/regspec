\name{regspec}
\alias{regspec}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Non-parametric Multirate Spectral Density Estimation via Linear Bayes.
}
\description{
This function computes a linear Bayes estimate and approximate credible
interval for the spectral density function
of a realization from a (second-order stationary) time series.
The function also has the
ability to update an existing spectral estimate
using time series data at a (potentially)
different sampling rate, and this can be repeated multiple times. In this way,
the routine can be used to estimate the spectrum, and credible
intervals, from time series data
taken at multiple sampling rates.
}
\usage{
regspec(D, deltat=1, nb=100, varmult=2, smthpar=0.8, ebeta=NULL,
	vbeta=NULL, filter=NULL, freq.out=seq(0,0.5,length=200),
	plot.spec=TRUE, plot.log=FALSE, plot.pgram=FALSE,
	plot.intervals=TRUE, ylim=NULL, SARIMA=list(sigma2=1),
	centred=FALSE,intname=NULL,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{D}{Vector. A time series of observations. If no prior information
	is specified (ie "starting case") then length of series has to
	be >= 2}
\item{deltat}{Integer. The number of unit time intervals between observations in the data set \code{D}.}
\item{nb}{Integer. The number of basis functions used to describe the spectral density.}
\item{varmult}{Scalar. A scaling factor for the variance of the basis coefficients for the log-spectrum.}
\item{smthpar}{Scalar. A roughness parameter between 0 and 1, controlling the exponential decay of the basis coefficient variances. Smaller values correspond to greater preference for smoothness.}
\item{ebeta}{Vector. Prior expectations for the basis coefficients of the log spectrum. Specifying prior moments for the coefficients overrides prior information encoded in \code{forvarest}.}
\item{vbeta}{Matrix. Prior covariances for the basis coefficients of the log spectrum.}
\item{filter}{Vector. A known vector of filter coefficients arising from
	the observation process prior to any subsampling.
	The default is \code{NULL}, which corresponds to direct observation
	and a filter vector of \code{(1,0,0,...)}.
	If the data are produced by taking a linear combination of the
	current and previous process values with weights \code{w_t},
	for example, one would set this vector to be \code{(w_{t},w_{t-1})}.}
\item{freq.out}{Vector. The frequencies at which to evaluate the estimated spectral density.}
\item{plot.spec}{Logical. If \code{TRUE} some kind of spectral plot is
	produced. If \code{FALSE} then no plot is produced.}
\item{plot.log}{Logical. Should the estimate of the log-spectrum be plotted? Plots the un-logged spectrum if \code{FALSE}.}
\item{plot.pgram}{Logical. Should the periodogram values be plotted on top of the spectrum estimate?}
\item{plot.intervals}{Logical. Should the pointwise credible intervals be plotted?}
\item{ylim}{The usual limits that specify the range of values on the y-axis}
\item{SARIMA}{List. A list encoding the SARIMA model that acts as the intercept, or base line, for the non-parametric estimate of the log-spectrum. The default is white noise with variance one. The log-spectrum basis coefficients parameterize a deviation away from the SARIMA model's log-spectrum. The contents of the SARIMA list are formatted in line with the format used by the package \code{TSA} (see the \code{Examples} section for examples).}
\item{centred}{Logical. Has the data been centred? If the data
	\code{D} has exactly zero mean, then the log-periodogram will
	return infinite values. By setting this option to TRUE,
	the infinite log-periodogram value is ignored.}
\item{intname}{Character. A name for the units the time intervals are measured in. This is just used to label the axes.}
\item{...}{Other arguments for call to plot}
}

\details{Full technical details of the calculations preformed by
	\code{regspec} are documented in Nason, Powell, Elliott and Smith (2016)
	listed in the references.

	This function can be used to produce an estimate of the spectrum
	of a stationary time series realization using linear Bayes
	methods. The simplest call just requires the user to specify
	\code{D} the vector of time series observations.

	More specialised uses of this function are as follows.
	1. One can additionally specify the value of the argument
	\code{deltat} to be the sampling interval of the time series.
	E.g. \code{deltat=2} means that the time series observations
	were sampled every two units of time. With this argument specified
	the spectrum is calculated/(depicted if plotted) \emph{still}
	on the frequency scale zero to one half, which is the scale
	normally associated with unit interval sampling. However, what changes
	is that the spectral estimate is neutrally extended from the
	\emph{subsampled} frequency range to the unit interval range.
	For example, if \code{deltat=2} then the usual frequency range
	assocated with data at this sampling interval would be zero to
	one quarter. However, the premise of \code{regspec} is that
	ultimately the series you obtained came from a unit sampled
	series and so the \emph{real spectrum} you would like to estimate
	is one zero to one half. Since we have no information on the higher
	frequencies zero to one quarter the code essentially unfolds the
	spectrum equally about the line of symmetry at one quarter.

	If \code{deltat=3} or other higher values, similar unfoldings occur.
	For example, if \code{deltat=4} then two unfoldings about
	one quarter and then one-eighth and three-eighths are affected.

	Then, subsequent calls to \code{regspec} at different sampling
	rates can alter the spectrum depending on the information they contain.

	Another key parameter is the \code{smthpar} which is set at
	0.8 by default which usually gives a nice balance between fidelity
	and smoothness. Increasing this parameter results in a less smooth
	estimate.

	By default aliasing is assumed to be induced by subsampling.
	For example, when \code{deltat=2} then it is assumed that the
	series you have contains the evenly-indexed observations of some
	putative underlying integer sampled series. However, aliasing can
	arise in other ways, such as when your unit sampled underlying series
	has been filtered. For example, if one observes quarterly totals,
	where each total is the result of summing over consecutive three
	month periods then the filter is \code{c(1,1,1)}.


A plot of the estimated spectrum is produced automatically unless the argument \code{plot.spec} is set to \code{FALSE}.
}
\value{
The function's output is a list with the following elements:
\item{freq.out}{Vector. The frequencies at which the estimated spectral density is computed.}
\item{spec}{Vector. Point estimates of the spectrum values. Each of these is computed by exponentiating the sum of the expectation for the log spectrum and half its variance. This is the expectation consistent with the log-spectrum being normally distributed.}
\item{logspec}{Vector. Point estimates for the log-spectrum values. These are the adjusted expectations of the log-spectrum.}
\item{interval}{Matrix. Bounds for the 90 percent credible interval for the the spectral density.}
\item{ebeta}{Vector. The adjusted expectation for the basis coefficients of the logged spectral density. They contain information on the current estimate
	of the spectrum and can be supplied to a further call of \code{regspec}
	for adjustment by new data.}
\item{vbeta}{Matrix. The adjusted variance matrix for the basis coefficients of the logged spectral density. Like \code{ebeta} this matrix can be resupplied
	to a further call to \code{regspec} for adjustment.}
\item{pgram}{List. The periodogram ordinates used in the adjustment.}
}

\author{
Ben Powell code. Ben Powell and Guy Nason on help.
}

\references{
Nason, G.P., Powell, B., Elliott, D. and Smith, P. (2016)
	Should We Sample a Time Series More Frequently? Decision Support
	via Multirate Spectrum Estimation.
	Journal of the Royal Statistical Society, Series A., 179,
	(to appear).
}

\examples{
## The examples here use datasets Dfexample, Dpexample2, Dpexample3 and
## spec.true, which should be loaded automatically with the package.


# FIRST EXAMPLE
# Estimates a spectrum from a time series observed at integer time points.
#
# Plot a 'point' estimate and intervals around it.
# Also plot the true spectrum afterwards with a dashed line
#
adjustment <- regspec(D=Dfexample[1:24], deltat=1, smthpar=0.8,
		ylim=c(0,60), plot.pgram=TRUE)

lines(spec.true, col=1, lwd=3, lty=2)

#
#
# SECOND EXAMPLE
# Does he same except the observations are sampled at every two time units.
#
# Plot a 'point' estimate and intervals around it.

adjustment <- regspec(D=Dpexample2, deltat=2, smthpar=0.8, ylim=c(0,60))

lines(spec.true, col=1, lwd=3, lty=2)

#
# THIRD EXAMPLE
# Now estimate a spectrum from unit sampled data and put answer in the
# object called adjustment1. Then use the estimated quantities in this
# object (notably the ebeta and vbeta components) to update the spectral
# estimate by a second call to regspec using new, data sampled at even time
# points and put the result into the adjustment2 object
#

adjustment1 <- regspec(D=Dfexample[1:24], deltat=1, smthpar=0.8,
	ylim=c(0,60))

lines(spec.true, col=1, lwd=3, lty=2)

adjustment2 <- regspec(D=Dpexample2, deltat=2, ebeta=adjustment1$ebeta,
	vbeta=adjustment1$vbeta, ylim=c(0,60))

lines(spec.true, col=1, lwd=3, lty=2)


# FOURTH EXAMPLE
# Estimate spectrum from series observed at each third integer.
# Plot a 'point' estimate and intervals around it.

adjustment <- regspec(D=Dpexample3, deltat=3, smthpar=0.8, ylim=c(0,60))

lines(spec.true, col=1, lwd=3, lty=2)

# FIFTH EXAMPLE
# Estimate a spectrum from one time series of observations at every
# time point and then update with another at every third time point.
#
# Note how information from the first spectral estimate gets passed to
# the second call of regspec via the ebeta and vbeta components/arguments.
#

adjustment1 <- regspec(D=Dfexample[1:24], deltat=1, smthpar=0.8, ylim=c(0,60))

lines(spec.true, col=1, lwd=3, lty=2)

adjustment2 <- regspec(D=Dpexample3, deltat=3, ebeta=adjustment1$ebeta,
	vbeta=adjustment1$vbeta, ylim=c(0,60))

lines(spec.true, col=1, lwd=3, lty=2)

# SIXTH EXAMPLE
#
# Estimating a spectrum from a time series of filtered observations.

# Filter the example data.

# Create empty vector
Dfexample.filtered <- c()

# Create filter
filter.vect <- 4*runif(5)

# Now produce filtered data
m <- length(filter.vect)-1

for(i in 1:(length(Dfexample)-m)){
	Dfexample.filtered[i] <- crossprod(Dfexample[i+m-0:m],filter.vect)
	}

# Now use filterered data to try and estimate spectrum of original data

adjustment1 <- regspec(D=Dfexample.filtered, smthpar=0.8, filter=filter.vect,
	ylim=c(0,80), plot.pgram=TRUE)

lines(spec.true, col=1, lwd=3, lty=2)

# Note here how the periodogram values do not correspond to the estimated
# spectrum because the periodogram of the  filtered data is computed and
# plotted, but then is used to estimate the spectrum of the un-filtered
# process.


# SEVENTH EXAMPLE
# Estimate spectrum according to its deviation from a known SARIMA model.

# Define a SARIMA model like this one

SARIMA0 <- list(ar=0.3,sigma2=1,seasonal=list(sar=0.5,sma=0,period=12))

# or like this one

SARIMA0 <- list(ar=c(-0.5, 0.4, 0.8), ma=0.2, sigma2=1)

# Then perform adjustments as before

adjustment <- regspec(D=Dfexample[1:16], deltat=1, smthpar=0.8, ylim=c(0,60),
	SARIMA=SARIMA0, plot.pgram=TRUE)

adjustment <- regspec(D=Dpexample2, deltat=2, smthpar=0.8, ylim=c(0,60),
	SARIMA=SARIMA0, plot.pgram=TRUE)

lines(spec.true, col=1, lwd=3, lty=2)

# This is useful for introducing prior beliefs for the structural form of the
# spectrum. Specifically, it is useful for specifying a prior belief in
# seasonality.
}
\keyword{ ts }
\keyword{ smooth }
