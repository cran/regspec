\name{Gaussbound}
\alias{Gaussbound}
\title{
Compute the Gauss bounds for a random variable.
}
\description{
This is a simple function that computes bounds for a credible interval
according to Gauss's inequality. If a random variable has a Lebesgue density
with a single mode (\code{mode}) and a finite expected squared
deviation (\code{tau}^2) from this mode,
then Gauss's inequality tells us that at least a
given proportion (\code{prob}) of the distribution's mass lies within a
finite symmetric interval centred on the mode.
}
\usage{
Gaussbound(mode, tau, prob)
}
\arguments{
  \item{mode}{
    Numeric. The location of the density's mode.
  }
  \item{tau}{
    Numeric. The square root of the expected squared deviation from the mode.
  }
  \item{prob}{
    Numeric. A lower bound on the probability mass that is contained within the interval
  }
  }
\value{
  \item{bounds}{An ordered vector containing the lower and upper bounds of the interval.}
  }
\author{
  Ben Powell
 }
\references{
Pukelsheim, F. (1994) The Three Sigma Rule. \emph{The American Statistician}
\bold{48}, 88-91.
}
\examples{
Gaussbound(1,1,0.9)
}

