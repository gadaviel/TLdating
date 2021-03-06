#' Extract preheat
#'
#'  This function provides a new \code{\linkS4class{TLum.Analysis}} object containing only the preheat curves.
#'
#' @param object
#'  \code{\linkS4class{TLum.Analysis}} (\bold{required}): object containing the initial TL curves.
#' @param plotting.parameters
#'  \link{list} (with default): list containing the plotting parameters. See details.

#'@details
#'  \bold{Plotting parameters} \cr
#'  The plotting parameters are:  \cr
#'  \describe{
#'  \item{\code{no.plot}}{
#'    \link{logical}: If \code{TRUE}, the results will not be plotted.}
#' }
#'
#' @return
#'  This function provides a new \code{\linkS4class{TLum.Analysis}} object with only the preheat curve. \cr
#'  It also plots the preheat curves and the TL curves using \link{plot_remove.preheat}.
#'
#' @seealso
#'  \link{plot_remove.preheat}
#'
#' @author David Strebler, University of Cologne (Germany).
#'
#' @export mod_extract.preheat

mod_extract.preheat <- function(

  object,

  plotting.parameters=list(no.plot=FALSE)

){
  C_PREHEAT <- "Preheat" #new#


  # ------------------------------------------------------------------------------
  # Integrity Check
  # ------------------------------------------------------------------------------
  if (missing(object)){
    stop("[mod_extract.preheat] Error: Input 'object' is missing.")
  }else if (!is(object,"TLum.Analysis")){
    stop("[mod_extract.preheat] Error: Input 'object' is not of type 'TLum.Analysis'.")
  }

  if(!is.list(plotting.parameters)){
    stop("[mod_extract.preheat] Error: Input 'plotting.parameters' is not of type 'list'.")
  }
  # ------------------------------------------------------------------------------

  nRecords <- length(object@records)

  test.preheat <- logical()

  PH <- vector()
  PH.error <- vector()
  TL <- vector()
  TL.error <- vector()

  PH.temperatures <- vector()
  PH.times <- vector()

  TL.temperatures <- vector()
  TL.times <- vector()

  for(i in 1:nRecords){
    temp.record <- object@records[[i]]

    temp.curve <- temp.record@data
    temp.curve.error <- temp.record@error
    temp.temperatures <- temp.record@temperatures

    temp.metadata <- temp.record@metadata

    temp.nPoints <- temp.metadata$NPOINTS
    temp.dtype <- temp.metadata$DTYPE

    temp.Tmax <- temp.metadata$HIGH
    temp.Trate <- temp.metadata$RATE

    temp.gr_time <- temp.Tmax/temp.Trate
    temp.an_time <- temp.metadata$AN_TIME
    temp.Dmax <- temp.gr_time + temp.an_time

    temp.Dstep <- temp.Dmax/temp.nPoints

    temp.times <- seq(from=temp.Dstep, to=temp.Dmax, by=temp.Dstep)

    if(temp.dtype == C_PREHEAT){

      test.preheat[i] <- TRUE

      PH <- cbind(PH,temp.curve)
      PH.error <- cbind(PH.error,temp.curve.error)

      PH.temperatures <- cbind(PH.temperatures,temp.temperatures)
      PH.times<- cbind(PH.times,temp.times)

    }else{

      test.preheat[i] <- FALSE

      TL <- cbind(TL,temp.curve)
      TL.error <- cbind(TL.error,temp.curve.error)

      TL.temperatures <- cbind(TL.temperatures,temp.temperatures)
      TL.times <- cbind(TL.times,temp.times)
    }
  }



  #----------------------------------------------------------------------------------------------
  # Generate TLum.Analysis
  #----------------------------------------------------------------------------------------------
  #temp.id <- 0

  new.records <- list()

  for(i in 1:nRecords){
    temp.record <- object@records[[i]]

    if(test.preheat[i] == TRUE) {

      #temp.id <- temp.id+1
      #temp.record@metadata$ID <- temp.id

      new.records <- c(new.records, temp.record)
    }
  }

  new.protocol <- object@protocol

  new.history <- c(object@history,
                   as.character(match.call()[[1]])
                   )

  new.plotData <- list(PH.signal=PH,
                       PH.temperatures=PH.temperatures,
                       PH.times=PH.times,
                       TL.signal=TL,
                       TL.temperatures=TL.temperatures)

  new.plotHistory <- object@plotHistory
  new.plotHistory[[length(new.plotHistory)+1]] <- new.plotData


  new.analysis <- set_TLum.Analysis(records = new.records,
                                    protocol = new.protocol,
                                    history = new.history,
                                    plotHistory = new.plotHistory)

  #--------------------------------------------------------------------------------------------------------
  #Plot results
  #--------------------------------------------------------------------------------------------------------
  no.plot <- plotting.parameters$no.plot

  # ------------------------------------------------------------------------------
  # Value check
  if(is.null(no.plot) || is.na(no.plot) || !is.logical(no.plot)){
    no.plot <- FALSE
  }
  # ------------------------------------------------------------------------------

  if(!no.plot){
    do.call(plot_remove.preheat,
            new.plotData)
  }

  #----------------------------------------------------------------------------------------------
  #Return results
  #----------------------------------------------------------------------------------------------

  return(new.analysis)
}
