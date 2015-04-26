# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

# Install and load the libraries we will need - only if needed
list.of.packages <- c("shiny", 
                      "BH", 
                      "rCharts", 
                      "data.table", 
                      "dplyr",
                      "ggvis",
                      "mapproj")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(shiny)
library(rCharts)
library(ggvis)
library(mapproj)

shinyUI(
  navbarPage("CMS Medicare Spending Data Explorer (2012)",
             tabPanel("Plot",
                      sidebarPanel(
                        uiOutput("evtypeControls"),
                        actionButton(inputId = "clear_all", label = "Clear selection", icon = icon("check-square")),
                        actionButton(inputId = "select_all", label = "Select all", icon = icon("check-square-o"))
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          
                          # Data by state
                          tabPanel(p(icon("map-marker"), "By State"),
                                   column(7,
                                          plotOutput("valueByState")
                                  
                                   )
                                   
                          ),
                                                                 
                          # Data 
                          tabPanel(p(icon("table"), "Data"),
                                   dataTableOutput(outputId="table"),
                                   downloadButton('downloadData', 'Download')
                          )
                        )
                      )
                      
             ),
             
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("include.md")
                      )
             )
  )
)