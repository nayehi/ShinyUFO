library(shiny)
library(leaflet)
library(dplyr)
library(lubridate)
library(RColorBrewer)
library(data.table)

ufo_dat <- read.csv("ufo_scrubbed.csv",header=TRUE,sep=",")
ufo_final <- data.frame(ufo_dat)
ufo_final$latitude <- as.numeric(as.character(ufo_final$latitude))
ufo_final$longitude <- as.numeric(as.character(ufo_final$longitude))
ufo_final$date <- as.Date(ufo_final$date, format = "%m/%d/%Y")
ufo_final$year <- year(ufo_final$date)
ufo_final <- subset(ufo_final,country=="us", na.rm=TRUE)
ufo_final$shape <- sub("^$", "Unspecified", ufo_final$shape)
ufo_fortable <- data.frame(ufo_final$year,ufo_final$shape)



server <- function(input,output){

  output$year_selected <- renderText({
    input$year
  })
  
  ufo_select <- reactive({
    
    ufo_final %>% filter(year==input$year)
    
  })
  
  ufo_fortable_select <- reactive({
    
    ufo_fortable %>% filter(ufo_final.year==input$year)
    
  })
  
  outputtablemake1 <- reactive({
    
    d1 <- aggregate(ufo_fortable_select(),list(ufo_fortable_select()$ufo_final.shape), length)
    d2 <- d1[,1:2]
  })
  
  output$ufo_count <- reactive({
    ufo_count_final <- nrow(ufo_select())
    paste("Number of Observations: ",ufo_count_final)
    
  })
  
  

  
  output$ufo_head2 <- renderText({
    paste(input$year,ufo_count_final,sep=(" (Number of Observations:"))
  })
  
 
     output$table_ufo <- renderDataTable({
     outputtablemake1()
     },
     options = list(processing=FALSE,
                    orderClasses = TRUE,
                   columns = list(
                     list(title = 'UFO Shape'),
                     list(title = 'Total Observed in Year'))
                   
                    
          )
)
  
 
  cols = brewer.pal(4, "BuPu") 
  cols = colorRampPalette(cols)(35)
  
  
  
   output$mymap <- renderLeaflet({
  pal <- colorFactor(
    palette = colorRampPalette(c('blue','black'))(length(ufo_select()$shape)),
    domain=ufo_select()$shape)
    
  
  m <- leaflet(ufo_select()) %>%
         addTiles() %>%
    addMarkers(popup = paste("Shape:",ufo_select()$shape,"<br>","Date:",ufo_select()$date),
               label = paste("Date:",ufo_select()$date),
               clusterOptions = markerClusterOptions(lng = ~ufo_select()$longitude,
               lat = ~ufo_select()$latitude)) %>%
               fitBounds(lng1 = -120, lat1 = 30, lng2 = -60, lat2=50) %>%
               setView(lng=-98.35,lat=39.50,zoom=3.25)
  m
     
})
  
  }