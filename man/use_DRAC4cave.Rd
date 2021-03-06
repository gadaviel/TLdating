% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/use_DRAC4cave.R
\name{use_DRAC4cave}
\alias{use_DRAC4cave}
\title{Calculation of the dose rate for a sediment sample coming from a cave}
\usage{
use_DRAC4cave(data, notification = TRUE)
}
\arguments{
\item{data}{\link{list}: data object create throught the function \link{template_DRAC4cave}.}

\item{notification}{\link{logical} (default): set to \code{FALSE} if you don't want to see the legal notification.}
}
\value{
This function return a \linkS4class{TLum.Results} object containing the Age estimation, the dose rates
 (total, internal, external, environmental, alpha, beta, gamma and cosmic), the equivalent dose used and their uncertainties.
}
\description{
This function allows to estimating the dose rate for a grain which was surrounded by sediment and rocks.
It call the \link{use_DRAC} and \link{calc_CosmicDoseRate} functions from the R package '\link{Luminescence}'.
The function 'use_DRAC' is only compatible wth DRAC version 1.1.
}
\author{
David Strebler
}
