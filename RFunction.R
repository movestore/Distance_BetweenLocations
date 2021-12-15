library('move')
library("ggplot2")
library("sf")
library("units")

## add in readme: "To check your projection go to:.... " in documentation when this is possible

rFunction <-  function(data) {
    if(st_crs(crs(data))$IsGeographic){ ## using pkg units so units are kept for the future
      unt <- "m" ## latlong result is in m/s
    }else{
      unt <- st_crs(crs(data))$units ## get units from projection
    }
    if(is.null(unt)){logger.warn("It seems that the projection does not have defined units, please check the projection in the study summary, and use changeProjection if necesary")} ## THIS WARNING HAS TO BE REWRITTEN!!!!! ITS BASICALLY A PLACEHOLDER. I actually do not know if this can happen, but just in case...
  udunits_from_proj <-  list( ## function borrowed from R library "sf", and modified
    #   PROJ.4     UDUNITS
    `km` =    "km",
    `m` =      "m",
    `dm` =     "dm",
    `cm` =     "cm",
    `mm` =     "mm",
    `kmi` =    "nautical_mile",
    `in` =     "in",
    `ft` =     "ft",
    `yd` =     "yd",
    `mi` =     "mi",
    `fath` =   "fathom",
    `ch` =     "chain",
    `link` =   "link", # not (yet) existing; set in .onLoad()
    `us-in` =  "us_in",
    `us-ft` =  "US_survey_foot",
    `us-yd` =  "US_survey_yard",
    `us-ch` =  "chain",
    `us-mi` =  "US_survey_mile",
    `ind-yd` = "ind_yd",
    `ind-ft` = "ind_ft", 
    `ind-ch` = "ind_ch"
  )
  udunt <- udunits_from_proj[[unt]]
  unts <- as_units(paste0(udunt,"/s"), check_is_valid = FALSE)
    data$speed <- set_units(unlist(lapply(speed(data), function(x) c(as.vector(x), NA))), unts, mode = "standard")
    
    if(length(levels(trackId(data)))==1){
      dataDF <- data.frame(speed=data$speed,indv=namesIndiv(data))
      speedHist <- ggplot(dataDF, aes(as.numeric(speed)))+geom_histogram(bins=100)+facet_grid(~indv)+ xlab(paste0("Speed ",paste0("(",udunt,"/s)")))+theme_bw()
      pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "distance_histogram.pdf"))
      print(speedHist)
      dev.off()
    } else {
    pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "distance_histogram.pdf"))
    speedHistAll <- ggplot(data@data, aes(as.numeric(speed)))+geom_histogram(bins=100)+ xlab(paste0("Speed ",paste0("(",udunt,"/s)")))+ggtitle("All Individuals") +theme_bw()
    print(speedHistAll)
    lapply(split(data), function(x){
      dataDF <- data.frame(speed=x$speed, indv=namesIndiv(x)) 
      speedHist <- ggplot(dataDF, aes(as.numeric(speed)))+geom_histogram(bins=100)+facet_grid(~indv)+ xlab(paste0("Speed ",paste0("(",udunt,"/s)")))+theme_bw()
      print(speedHist)
    })
    dev.off() 
    
  }
  return(data)
}