library(shiny)

players <- read.csv("data/fifa2019.csv", stringsAsFactors = FALSE)

ui <- fluidPage(

)

server <- function(input, output, session) {

}

shinyApp(ui, server)
