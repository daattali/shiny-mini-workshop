library(shiny)

players <- read.csv("data/fifa2019.csv", stringsAsFactors = FALSE)

print(nrow(players))

ui <- fluidPage(
  nrow(players)
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
