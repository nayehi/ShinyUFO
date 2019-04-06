# ShinyUFO
This repository holds files associated with the ShinyUFO Project.

# Introduction
This project describes a Shiny Application that displays information about UFO sightings in the United States.
The application uses Leaflet to generate a U.S. map showing the phenomenon of UFO sightings by location. The user chooses the year to display by adjusting a slider.
Clusters are generated interactively, reforming as the user zooms in or out.
Each individual observation, when clicked, displays a popup showing the associated UFO Shape and Date.
In addition, a table beneath the map displays the total count for each UFO Shape for the year.
Files associated with this project are published on GitHub.
Data
This project uses UFO Sightings data from the National UFO Reporting Center (NUFORC), which is dedicated to the Collection and Dissemination of Objective UFO Data.
The data was downloaded from the UFO Sightings page on Kaggle. The file was 'scrubbed.csv', which includes only records that have location and time values.
This dataset described 80,332 reports of UFO sightings over the last century. For this project, only records with 'us' in the Country field were included. This resulted in a dataset of 64,133 observations of 11 variables. The data was further subset to include only the datetime, shape, latitude, and longitude columns. A new field, date, was created from datetime by extracting the date via lubridate.

# Data
This project uses UFO Sightings data from the National UFO Reporting Center (NUFORC), which is dedicated to the Collection and Dissemination of Objective UFO Data.
The data was downloaded from the UFO Sightings page on Kaggle. The file was 'scrubbed.csv', which includes only records that have location and time values.
This dataset described 80,332 reports of UFO sightings over the last century. For this project, only records with 'us' in the Country field were included. This resulted in a dataset of 64,133 observations of 11 variables. The data was further subset to include only the datetime, shape, latitude, and longitude columns. A new field, date, was created from datetime by extracting the date via lubridate.
