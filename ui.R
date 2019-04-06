library(shiny)
library(leaflet)
library(dplyr)
library(lubridate)
ufo_dat2 <- read.csv("ufo_scrubbed.csv",header=TRUE,sep=",")
ufo_final2 <- data.frame(ufo_dat2)
ufo_final2$latitude <- as.numeric(as.character(ufo_final2$latitude))
ufo_final2$longitude <- as.numeric(as.character(ufo_final2$longitude))
ufo_final2$date <- as.Date(ufo_final2$date, format = "%m/%d/%Y")
ufo_final2$year <- year(ufo_final2$date)
ufo_final2 <- subset(ufo_final2,country=="us",na.rm=TRUE)

shapes <- unique(sort(ufo_final2$shape))
years <- unique(sort(ufo_final2$year))
yearmax <- max(ufo_final2$year)
yearmin <- min(ufo_final2$year)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("UFO Sightings in the U.S."),
  headerPanel(""),
  h6("Based on"),
  h6("UFO Sightings data"),
  h6("from National UFO Reporting Center (NUFORC)"),
  headerPanel(""),
  headerPanel(""),
  
  # Sidebar with a slider input for year 
  sidebarLayout(
    sidebarPanel(
      
      p("Use the slider below to choose a year."),
      
      
      sliderInput("year","Year:",min=yearmin,max=yearmax,value=yearmax,sep="")
                 ),
    
    # Show a plot of the data
    mainPanel(
      h1(span(textOutput("year_selected")),style="color:lightblue"),
      h4(textOutput("ufo_count")),
      leafletOutput("mymap", width = "100%"),
      dataTableOutput("table_ufo")
      )
              )
)
)


