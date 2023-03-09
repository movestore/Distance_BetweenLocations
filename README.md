# Distance Between Locations

MoveApps

Github repository: https://github.com/movestore/Distance_BetweenLocations

## Description
Calculation of the straight line distance between consecutive locations.

## Documentation
This App calculates distance between each consecutive locations. This measurement is a segment characteristic, and will be assigned to the first location of each segment. Therefore the distance of the last location of the track will be set to NA. 

If the coordinates are geographic (i.e.long/lat) distance is calculated on a sphere using the ellipsoid, for other projections the calculation is done on a plane using Pythagoras.

A column named _**distance**_ will be appended to the dataset that is returned for further use in next Apps. This column also contains the **unit** information in which the distance was calculated. If the coordinates are geographic (i.e.long/lat) all values are returned in "meters", otherwise in the "map units" of the current projection.

A histogram of the distance distribution of all individuals and per individual is automatically created and can be downloaded in the output as a pdf. For the histogram the units can be customized for better visualization and/or understanding of the data.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
`distance_histogram.pdf`: PDF with histograms of the distances per individual

`distanceBetweenLocations.csv`: table containing the timestamps, longitude, latitude, individual Id and calculated distance between locations. The column name of the distance contains the unit information after the underscore, e.g "distance_m". The units correspond to the map units of the data (see documentation).

### Settings
**Select units for plot (`units`):** units displayed in the histogram can be selected. Available are: `centimeters`, `meters`, `kilometers`, `inches`, `feet`, `yards` & `miles`. Default is the *map unit* of the data (see documentation). 

### Null or error handling
**Data**: The full input dataset with the addition of distance is returned for further use in a next App and cannot be empty.

**Units**: 

  - If the projection does not have defined units, a warning message will be issued.
  
  - If *map units* are: "link", "us_in", "ind_yd", "ind_ft", "ind_ch" or not defined, there is no conversion available to display other units in the histogram. Example error message: `Error: cannot convert us_in into km`


