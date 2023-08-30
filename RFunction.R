library('move2')
library("units")
library("ggplot2")
library("sf")

rFunction <-  function(data, units) { 
      data$distance <- mt_distance(data, units=units)

    if(mt_n_tracks(data)==1){
      distanceHist <- ggplot(data[!is.na(data$distance),], aes(distance))+geom_histogram(bins=100)+facet_grid(~.data[[mt_track_id_column(data)]])+ xlab("Distance")+theme_bw()
      pdf(appArtifactPath("distance_histogram.pdf"))
      print(distanceHist)
      dev.off()
  
      outDF <- data.frame(timestamps=mt_time(data),location.long=sf::st_coordinates(data)[,1],location.lat=sf::st_coordinates(data)[,2], track_id=mt_track_id(data), distance=data$distance)
      colnames(outDF)[5] <- paste0(colnames(outDF)[5],"_", units(data$distance)$numerator)
      write.csv(outDF, row.names=F, file = appArtifactPath("distanceBetweenLocations.csv"))
    } else {
    pdf(appArtifactPath("distance_histogram.pdf"))
    distanceHistAll <- ggplot(data[!is.na(data$distance),], aes(distance))+geom_histogram(bins=100)+ xlab("Distance")+ggtitle("All Individuals")+ theme_bw()
    print(distanceHistAll)
    lapply(split(data, mt_track_id(data)), function(dataI){
      distanceHist <- ggplot(dataI[!is.na(dataI$distance),], aes(distance))+geom_histogram(bins=100)+facet_grid(~.data[[mt_track_id_column(dataI)]])+ xlab("Distance")+theme_bw()
      print(distanceHist)
    })
    dev.off() 
    
    outDF <- data.frame(timestamps=mt_time(data),location.long=sf::st_coordinates(data)[,1],location.lat=sf::st_coordinates(data)[,2], track_id=mt_track_id(data), distance=data$distance)
    colnames(outDF)[5] <- paste0(colnames(outDF)[5],"_", units(data$distance)$numerator)
    write.csv(outDF, row.names=F, file = appArtifactPath("distanceBetweenLocations.csv"))
  }
  return(data)
}
