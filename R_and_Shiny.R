library(shiny)
library(shinyWidgets)
library(tidyverse)

ui <- fluidPage(
  titlePanel("TIEMPO DE GESTACIÓN"),
  sidebarLayout(
    sidebarPanel(
      setSliderColor(c("#b2df8a ", "#FF4500", "", "Teal"), c(1, 2, 4)),
      sliderInput(inputId = "barras",
                  label = "NÚMERO DE CONTENEDORES PARA AGRUPAR LOS DATOS:",
                  min = 5,
                  max = 20,
                  value = 13)
    ),
    mainPanel(
      plotOutput(outputId = "Plot")
    )
  )
)

server <- function(input, output) {
  output$Plot <- renderPlot({
    #Datos obtenidos desde https://people.math.sc.edu/Burkardt/datasets/csv/csv.html
    x <- read_csv("https://people.math.sc.edu/Burkardt/datasets/csv/birthweight.csv")$Gestation
    barras <- seq(min(x), max(x), length.out = input$barras + 1)
    
    h <- hist(x, breaks = barras, col = "#33a02c", border = "white",
         xlab = "SEMANAS DE GESTACIÓN",
         ylab = "FRECUENCIA",
         main = "HISTOGRAMA DEL TIEMPO DE GESTACIÓN")
    xfit <- seq(min(x), max(x), length = 40) 
    yfit <- dnorm(xfit, mean = mean(x), sd = sd(x)) 
    yfit <- yfit * diff(h$mids[1:2]) * length(x) 
    
    lines(xfit, yfit, col = "#b2df8ag", lwd = 2)
  })
  
}

shinyApp(ui = ui, server = server)

