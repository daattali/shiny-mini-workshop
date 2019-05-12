library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

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
        textOutput("num_players", inline = TRUE),
        "players in the dataset"
      ),
      plotOutput("fifa_plot"),
      DTOutput("players_data")
    )
  )
)

server <- function(input, output, session) {

  output$players_data <- renderDT({
    data <- players %>%
      filter(rating >= input$rating,
             nationality %in% input$country)

    data
  })

  output$num_players <- renderText({
    data <- players %>%
      filter(rating >= input$rating,
             nationality %in% input$country)

    nrow(data)
  })

  output$fifa_plot <- renderPlot({
    data <- players %>%
      filter(rating >= input$rating,
             nationality %in% input$country)

    ggplot(data, aes(value)) +
      geom_histogram()
  })

}

shinyApp(ui, server)
