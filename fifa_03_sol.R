library(shiny)

players <- read.csv("data/fifa2019.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("FIFA 2019 Player Stats"),
  sidebarLayout(
    sidebarPanel(
      "Exploring all player stats from the FIFA 2019 video game",
      h3("Filters"),
      sliderInput(
        inputId = "rating",
        label = "Player rating at least",
        min = 0, max = 100,
        value = 80
      ),
      selectInput(
        "country", "Player nationality",
        unique(players$nationality),
        selected = "Brazil"
      )
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
