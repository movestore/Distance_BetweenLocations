# Distance Between Locations

MoveApps

Github repository: https://github.com/movestore/Distance_BetweenLocations

## Description
Calculation of the straight line distance between consecutive locations.

## Documentation
This App calculates distance between each consecutive locations. This measurement is a segment characteristic, and will be assigned to the first location of each segment. Therefore the distance of the last location of the track will be set to NA. 

If the coordinates are geographic (i.e.long/lat) distance is calculated on a sphere using the ellipsoid, for other projections the calculation is done on a plane using Pythagoras.

**Units**: map units. If the coordinates are geographic (i.e.long/lat) all values are returned in "meters", otherwise in the "map units" of the current projection.

A histogram of the distance distribution of all individuals and per individual is automatically created and can be downloaded in the output as a pdf.

A column named _**distance**_ will be appended to the dataset that is returned for further use in next Apps.


### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
`distance_histogram.pdf`: PDF with histograms of the distances per individual

### Parameters
no parameters

### Null or error handling
**Data**: The full input dataset with the addition of distance is returned for further use in a next App and cannot be empty.

**Units**: If the projection does not have defined units, a warning message will be issued
