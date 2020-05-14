#
# Covid19 Shiny Dashboard. 
# Written by : Bakti Siregar, M.Si
# Department of Business statistics, Matana University (Tangerang)
# Notes: Please don't share this code anywhere (just for my students)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# A. PACKAGES----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(ggplot2)
library(plotly)
library(shiny)                                          # This packages use to create shiny web apps
library(markdown)
library(dplyr)


# B. PREPARE YOUR DATABASE  ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# covid19 = read.csv('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv')   
# write.csv(covid19,'Covid-19.csv')

# covid_19 <- read.csv2("Covid-19.csv")
# # View(covid_19)
# 
# Country         <- as.character  (covid_19$location)
# Region          <- as.character  (covid_19$region)
# Week            <- as.integer    (covid_19$week)
# Infected        <- as.numeric    (covid_19$total_cases)
# Death           <- as.numeric    (covid_19$total_deaths)
# 
# covid           <- cbind(Country, Region, Week, Infected, Death)
# covid_          <- as.data.frame(covid)
# 
# covid_$Country   <- as.character  (covid_$Country)
# covid_$Region    <- as.character  (covid_$Region)
# covid_$Week      <- as.integer    (covid_$Week)
# covid_$Infected  <- as.numeric    (covid_$Infected)
# covid_$Death     <- as.numeric    (covid_$Death)



# C. BUILD YOUR SHINY APP ----
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# C.1 User Interface (ui) ----
ui<-navbarPage("Dashboard",
               tabPanel("Covid19",titlePanel("Cases"), 
                        sidebarLayout(
                          sidebarPanel(DT::dataTableOutput("table1"),
                                       downloadButton("downloadData",
                                                      "Download Data Here",
                                                      href = "https://github.com/imelda85/Covid-19/blob/master/Covid-19.csv")),
                          mainPanel(tableOutput("table1`")))),
                                      
               tabPanel("Visualization",
                        plotlyOutput("plot")),
               
               tabPanel("Help", 
               titlePanel("Want to know more? Please contact:"),
               helpText("Imelda Sianturi ~ Student of 
               Matana University (Tangerang) at imeldasianturi85@gmail.com"),
                        sidebarLayout(
                          sidebarPanel(
                            downloadButton("downloadCode", 
                                           "Download Code and Data Here", 
                                           href = "https://github.com/imelda85/Covid-19/blob/master/Covid-19.R")),
                          mainPanel(tableOutput("table"))))
)

# C.2 Server ----
server<-function(input, output, session) {
  output$table1 <- DT::renderDataTable({DT::datatable(covid_)})
  
  output$plot <- renderPlotly(
    {ggplotly(ggplot(covid_, aes(Death, Infected, color = Region)) +
                geom_point(aes(size = Death, frame = Week, ids = Country)) +
                scale_x_log10())%>% 
        animation_opts(1000,easing="elastic",redraw=FALSE)})
  
  
}


shinyApp(ui, server)      # This is execute your apps






