library(shiny)

# Plotting 
library(ggplot2)
library(rCharts)
library(ggvis)

# Data processing libraries
library(data.table)
library(reshape2)
library(dplyr)

# Required by includeMarkdown
library(markdown)

# It has to loaded to plot ggplot maps on shinyapps.io
library(mapproj)
library(maps)

# Load helper functions
source("helpers.R", local = TRUE)

# Load data
states_map <- map_data("state")
dt <- fread('cms-2012-data.csv') %>% mutate(provider_type = tolower(provider_type))
evtypes <- sort(unique(dt$provider_type))

# Shiny server 
shinyServer(function(input, output, session) {
  
  # Define and initialize reactive values
  values <- reactiveValues()
  values$evtypes <- evtypes
  
  # Create event type checkbox
  output$evtypeControls <- renderUI({
    checkboxGroupInput('evtypes', 'Provider Types', evtypes, selected=values$evtypes)
  })
  
  # Add observers on clear and select all buttons
  observe({
    if(input$clear_all == 0) return()
    values$evtypes <- c()
  })
  
  observe({
    if(input$select_all == 0) return()
    values$evtypes <- evtypes
  })
  
  # Preapre datasets
  
  # Prepare dataset for maps
  dt.agg <- reactive({
    aggregate_by_state(dt, input$evtypes)
  })
    
  # Prepare dataset for downloads
  dataTable <- reactive({
    prepare_downloads(dt.agg())
  })
  
  # Render Plots
  
  # Population impact by state
  output$valueByState <- renderPlot({
    print(plot_impact_by_state (
      dt = compute_affected(dt.agg()),
      states_map = states_map, 
      title = "Medicare Spending by State",
      fill = "Spending"
    ))
  })
  
# Render data table and create download handler
output$table <- renderDataTable(
{dataTable()}, options = list(bFilter = FALSE, iDisplayLength = 50))

output$downloadData <- downloadHandler(
  filename = 'cms-2012-data.csv',
  content = function(file) {
    write.csv(dataTable(), file, row.names=FALSE)
  }
)
})
