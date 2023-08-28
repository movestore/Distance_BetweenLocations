# Distance Between Locations

MoveApps

Github repository: https://github.com/movestore/Distance_BetweenLocations

## Description
Calculation of the straight line distance between consecutive locations.

## Documentation
This App calculates distance between each consecutive locations. This measurement is a segment characteristic, and will be assigned to the first location of each segment. Therefore the distance of the last location of the track will be set to NA. 

A column named _**distance**_ will be appended to the dataset that is returned for further use in next Apps. This column also contains the **unit** information in which the distance was calculated. 

A histogram of the distance distribution of all individuals and per individual is automatically created and can be downloaded in the output as a pdf.

### Input data
move2_loc

### Output data
move2_loc

### Artefacts
`distance_histogram.pdf`: PDF with histograms of the distances per individual

`distanceBetweenLocations.csv`: table containing the timestamps, longitude, latitude, individual Id and calculated distance between locations. The column name of the distance contains the unit information after the underscore, e.g "distance_m". 

### Settings
**Units:** the units of the resulting values can be selected. Available are: `centimeters`, `meters`, `kilometers`. Default is `meters`

### Null or error handling
**Data**: The full input dataset with the addition of distance is returned for further use in a next App and cannot be empty.



