% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as.data.frame.R
\name{as.data.frame.icm}
\alias{as.data.frame.icm}
\alias{as.data.frame.netsim}
\title{Extract Model Data for Stochastic Models}
\usage{
\method{as.data.frame}{icm}(x, row.names = NULL, optional = FALSE,
  sim = "all", out = "mean", qval, ...)

\method{as.data.frame}{netsim}(x, row.names = NULL, optional = FALSE,
  sim = "all", out = "mean", ...)
}
\arguments{
\item{x}{An \code{EpiModel} object of class \code{icm} or \code{netsim}.}

\item{row.names}{See \code{\link{as.data.frame.default}}.}

\item{optional}{See \code{\link{as.data.frame.default}}.}

\item{sim}{If \code{out="vals"}, the simulation number to output, or the default of
\code{out="all"}, which outputs data from all simulations bound together.}

\item{out}{Data output to data frame: \code{"mean"} for row means across
simulations, \code{"sd"} for row standard deviations across simulations,
\code{"qnt"} for row quantiles at the level specified in \code{qval},
or \code{"vals"} for values from one individuals simulation(s).}

\item{qval}{Quantile value necessary when \code{out="qnt"}.}

\item{...}{See \code{\link{as.data.frame.default}}.}
}
\description{
This function extracts model simulations for objects of classes
             \code{icm} and \code{netsim} into a data frame using
             the generic \code{as.data.frame} function.
}
\details{
These methods work for both \code{icm} and \code{netsim}
class models. The available output includes time-specific means,
standard deviations, quantiles, and simulation values (compartment and flow
sizes from one simulation) from these stochastic model classes. Means and
standard deviations are calculated by taking the row summary across all
simulations for each time step in the model output.
}
\examples{
## Stochastic ICM SIS model with 5 simulations
param <- param.icm(inf.prob = 0.8, act.rate = 2, rec.rate = 0.1)
init <- init.icm(s.num = 500, i.num = 1)
control <- control.icm(type = "SIS", nsteps = 25,
                       nsims = 2, verbose = FALSE)
mod <- icm(param, init, control)

# Default output is mean across simulations
as.data.frame(mod)

# Standard deviations of simulations
as.data.frame(mod, out = "sd")

# Quantile values for interquartile interval
as.data.frame(mod, out = "qnt", qval = 0.25)
as.data.frame(mod, out = "qnt", qval = 0.75)

# Individual simulation runs, with default sim="all"
as.data.frame(mod, out = "vals")
as.data.frame(mod, out = "vals", sim = 2)

## Stochastic SI network model
nw <- network.initialize(n = 100, directed = FALSE)
formation <- ~edges
target.stats <- 50
coef.diss <- dissolution_coefs(dissolution = ~offset(edges), duration = 20)
est <- netest(nw, formation, target.stats, coef.diss, verbose = FALSE)

param <- param.net(inf.prob = 0.5)
init <- init.net(i.num = 10)
control <- control.net(type = "SI", nsteps = 10, nsims = 2, verbose = FALSE)
mod <- netsim(est, param, init, control)

as.data.frame(mod)
as.data.frame(mod, out = "vals")

}
\keyword{extract}
