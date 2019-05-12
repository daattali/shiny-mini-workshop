library(shiny)

players <- read.csv("data/fifa2019.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("FIFA 2019 Player Stats"),
  sidebarLayout(
    sidebarPanel(
      "Exploring all player stats from the FIFA 2019 video game"
    ),
    mainPanel(
      strong(
        "There are",
        nrow(players),
        "players in the dataset"
      )
    )
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
