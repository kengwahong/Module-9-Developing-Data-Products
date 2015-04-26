library(shiny)
library(ggplot2)
require(markdown)

#Loading and preparing the dataset
data(mtcars)
dataset <- mtcars
dataset$cyl<-as.factor(dataset$cyl)
dataset$am<-as.factor(dataset$am)
dataset$gear<- as.factor(dataset$gear)
dataset$gear<-as.factor(dataset$gear)
dataset$vs<-as.factor(dataset$vs)
dataset$carb<-as.factor(dataset$carb)

shinyUI(fluidPage(navbarPage("Motor Trend Car Road Tests",
                       
             tabPanel("Box Plot",
                      sidebarPanel(
                        
                        h3('Box Plot settings'),
                        p('Select the predictor variable with mpg as outcome:'),
                        selectInput('xAxis', 'X-Axis', selected = "cyl" , c('cyl', 'vs', 'am', 'gear', 'carb')),
                        tags$br(),
                        tags$br(),
                        strong('VARIABLE DESCRIPTIONS:'),
                        tags$ul(
                          tags$li('cyl - Number of cylinders'),
                          tags$li('vs - V/S'),
                          tags$li('am - Transmission (0 = automatic, 1 = manual)'),
                          tags$li('gear - Number of forward gears'),    
                          tags$li('carb - Number of carburetors')
                        )                 
                      ),
                      
                      mainPanel(
                        h2('Basic Introductory Exploratory Analysis'),
                        plotOutput('boxplot')     
                      )
                  
             ),
             
             tabPanel("GG Plot",
                      sidebarPanel(
                        
                        h3('GG Plot settings'),
                        p('Select the predictor variable'),
                        
                        selectInput('x', 'X-Axis', names(dataset), selected = "hp"),
                        selectInput('y', 'Y-Axis', names(dataset), selected = "mpg"),
                        selectInput('color', 'Color', selected = "cyl" , c('None', names(dataset))),
                        selectInput('size', 'Size', selected = "None" , c('None', names(dataset))),
                        
                        checkboxInput('smooth', 'Smooth'),
                        
                        tags$br(),
                        tags$br(),
                        strong('VARIABLE DESCRIPTIONS:'),
                        tags$ul(
                          tags$li('mpg - Miles/(US) gallon'),
                          tags$li('cyl - Number of cylinders'),
                          tags$li('disp - Displacement (cu.in.)'),
                          tags$li('hp - Gross horsepower'),
                          tags$li('drat - Rear axle ratio'),
                          tags$li('wt - Weight (lb/1000)'),
                          tags$li('qsec - 1/4 mile time'),
                          tags$li('vs - V/S'),
                          tags$li('am - Transmission (0 = automatic, 1 = manual)'),
                          tags$li('gear - Number of forward gears'),    
                          tags$li('carb - Number of carburetors')
                        ) 
                      ),
                      
                      mainPanel(
                        h2('Basic Introductory Exploratory Analysis'),
                        plotOutput('plot')     
                      )
             ),
             
             tabPanel("Pair Plot",
                      sidebarPanel(
                        
                        h3('Pair plot settings'),
                        p('Select any combinations of checkboxes'),
                        
                        checkboxInput('P_mpg', 'mpg - Miles/(US) gallon', value = T),
                        checkboxInput('P_cyl', 'cyl - Number of cylinders', value = T),
                        checkboxInput('P_disp', 'disp - Displacement (cu.in.)'),
                        checkboxInput('P_hp', 'hp - Gross horsepower'),
                        checkboxInput('P_drat', 'drat - Rear axle ratio'),
                        checkboxInput('P_wt', 'wt - Weight (lb/1000)'),
                        checkboxInput('P_qsec', 'qsec - 1/4 mile time'),
                        checkboxInput('P_vs', 'vs - V/S'),
                        checkboxInput('P_am', 'am - Transmission (0 = automatic, 1 = manual)'),
                        checkboxInput('P_gear', 'gear - Number of forward gears'),
                        checkboxInput('P_carb', 'carb - Number of carburetors')
                        
                      ),
                      
                      mainPanel(
                        h2('Basic Introductory Exploratory Analysis'),
                        plotOutput('pairPlot')     
                      )
             ),
             
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("Include.Rmd")
                      )
             )

  ) 
))