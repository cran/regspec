\name{logspec2cov}
\alias{logspec2cov}
\title{
Compute autocovariance values from the basis coefficients for the log spectrum.
}
\description{
This function performs a series of integrals of a spectral density
multiplied by sinusoids of increasing frequency in order.
The result is a vector of autocovariances for the process values at
increasing separation.

The example below shows how this function is useful for informing
estimates of missing values in thinned time series data.
}
\usage{
logspec2cov(ebeta, vbeta, SARIMA=list(sigma2=1), lags, subdivisions=100)
}
\arguments{
\item{ebeta}{
Vector. Expectations for basis coefficients of the log spectrum.
}
\item{vbeta}{
Vector. The variance for the basis coefficients of the log spectrum.
}
\item{SARIMA}{List. A list encoding the SARIMA model that acts as
the intercept, or base line, for the non-parametric estimate of
the log-spectrum. The default is white noise with variance one.
The log-spectrum basis coefficients parameterize a deviation away from
the SARIMA model's log-spectrum.
The contents of the SARIMA list are formatted in line with the
format used by the package \code{TSA} (see the \code{Examples}
section for examples).}
\item{lags}{
Integer. The number of lags to which to calculate the autocovariance.
}
\item{subdivisions}{
Integer. This number is passed to the numerical integrator that computes the autocovariances from the exponentiated log-spectrum. It is set to \code{100} by default to reduce CPU demand. For rough spectra is may be advisable to specify a larger value.
}
}
\value{
\item{}{A vector of approximate expectations for the process's
autocovariances for increasing lags, starting with zero lag
(the process variance).}
}
\author{
Ben Powell
}
\examples{
#
# Simulate a complete time series.

set.seed(42)
D <- arima.sim(n=150, model=list(ar=c(-0.5,0.4,0.8), ma=0.2))

# Now define indices for a subsampled historical period,
# a fully sampled historical period, and the missing values.

inda <- seq(1, 100, by=3)
indb <- seq(101, 150, by=1)
indc <- (1:150)[-c(inda, indb)]

#
# Adjust our estimate for the spectrum using the two historical periods.
#

adjustment1 <- regspec(D=D[indb], deltat=1, smthpar=0.85,
	plot.spec=FALSE)

adjustment2 <- regspec(D=D[inda], deltat=3, ebeta=adjustment1$ebeta,
	vbeta=adjustment1$vbeta, ylim=c(0,60))

lines(spec.true, col=1, lwd=3, lty=2)

#
# Calculate covariances corresponding to the estimate of the spectrum at
# the data locations.
#

k <- logspec2cov(adjustment2$ebeta, adjustment2$vbeta, lag=150)

#
# Compute linear predictors and variances for the missing data conditional
# on the autocovariances.
#

K <- matrix(0, 150, 150)
K <- matrix(k[1+abs(row(K)-col(K))], 150, 150)
d <- solve(K[c(inda, indb),c(inda, indb)],K[c(inda, indb), indc])
hindcast.exp <- crossprod(d, c(D[inda], D[indb]))
hindcast.var <- K[indc, indc]-crossprod(K[c(inda, indb), indc], d)

#
# Plot the observed historical data and the predictions for the missing data.
#

par(cex=0.7)
plot(NA, NA, xlim=c(0,150), ylim=range(D), xlab="time", ylab="x")

#
#(Observed process values are plotted with black circles.)
#

points(indb, D[indb], type="p", lty=2)
points(c(inda, indb), c(D[inda], D[indb]))

#
# (Hindcasts are plotted with blue circles.)
#
points(indc, hindcast.exp, col=rgb(0.2,0.5,0.7), lwd=2)
for(i in 1:length(indc))	{
	lines(rep(indc[i], 2),
	hindcast.exp[i]+1*c(-1, 1)*hindcast.var[i, i]^0.5,
	col=rgb(0.2,0.5,0.7))
	}

#
# Interpolate the plotted data and predictions.
#

x <- c(inda, indb, indc)
y <- c(D[inda], D[indb], hindcast.exp)
lines(sort(x), y[order(x)], lty=2, col=rgb(0.2,0.5,0.7,0.7))

#
# Reveal the true values.
#

# (The union of observed and unobserved data is plotted with red crosses.)
points(D,col=2,pch=4)
}
