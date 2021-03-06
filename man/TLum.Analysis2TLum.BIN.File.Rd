% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TLum.Analysis2TLum.BIN.File.R
\name{TLum.Analysis2TLum.BIN.File}
\alias{TLum.Analysis2TLum.BIN.File}
\title{Convert TLum.Analysis object to an TLum.BIN.File object.}
\usage{
TLum.Analysis2TLum.BIN.File(object)
}
\arguments{
\item{object}{\code{\linkS4class{TLum.Analysis}} (\bold{required}): object containing the luminescence curves.}
}
\value{
This function will return a \linkS4class{TLum.BIN.File} object.
}
\description{
This function convert a \linkS4class{TLum.BIN.File} in a \linkS4class{TLum.Analysis} object.
A \linkS4class{TLum.Analysis} object is a list of \linkS4class{TLum.Data.Curve} object.
It is possible to specify which luminescence curves will be keeped.
}
\seealso{
\linkS4class{TLum.Analysis},
 \linkS4class{TLum.BIN.File},
 \linkS4class{TLum.Data.Curve} and
 \link{TLum.BIN.File2TLum.Data.Curve}.
}
\author{
David Strebler, University of Cologne (Germany), \cr David Strebler
}
