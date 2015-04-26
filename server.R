library(shiny)
library(ggplot2)
library(GGally)

#Loading and preparing the dataset
data(mtcars)
dataset <- mtcars
dataset$cyl<-as.factor(dataset$cyl)
dataset$am<-as.factor(dataset$am)
dataset$gear<-as.factor(dataset$gear)
dataset$vs<-as.factor(dataset$vs)
dataset$carb<-as.factor(dataset$carb)

shinyServer(function(input, output)
  {
  #boxplot using User Input
  output$boxplot <- renderPlot({
    if(length(input$xAxis) == 0) return 
    
    yAxis <- 'mpg'
        
    # initial frame and axes description
    chartVar <- ggplot(data = dataset) 
    x <- input$xAxis
    y <- yAxis
      
    # plot the graph
    chartVar <- chartVar +
    geom_boxplot(aes_string(x = input$xAxis, fill = input$xAxis, y = yAxis)) + 
      labs(x = input$xAxis, y = yAxis, title = paste(y,'versus',x))
        
    # Printing the graph
    print(chartVar) 
      
    }, height = 700)
    
    #boxplot using User Input
    output$plot <- renderPlot({
      p <- ggplot(dataset, aes_string(x=input$x, y=input$y)) + geom_point()
      if (input$size != 'None') {
        p <- p + aes_string(size=input$size) }
      
      if (input$color != 'None') 
        p <- p + aes_string(color=input$color)

      if (input$smooth)
        p <- p + geom_smooth()
      print(p)
      
    }, height=700)
    
    #boxplot using User Input
    output$pairPlot <- renderPlot({
      bool_vec<-c(input$P_mpg,
                  input$P_cyl,
                  input$P_disp,
                  input$P_hp,
                  input$P_drat,
                  input$P_wt,
                  input$P_qsec,
                  input$P_vs,
                  input$P_am,
                  input$P_gear,
                  input$P_carb)
      
      if(sum(bool_vec)>1) {
        columns <- 1:ncol(dataset)
        columns <- columns[bool_vec]
        p <- ggpairs(dataset, columns = columns)
        print(p)
      }
    }, height = 700)
  }
)