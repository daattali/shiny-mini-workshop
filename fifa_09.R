library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(colourpicker)

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
        value = c(80, 100)
      ),
      selectInput(
        "country", "Player nationality",
        unique(players$nationality),
        selected = "Brazil",
        multiple = TRUE
      ),
      h3("Plot options"),
      selectInput("variable", "Variable", c("rating", "wage", "value", "age"), "value"),
      radioButtons("plot_type", "Plot type", c("histogram", "density"))
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

  filtered_data <- reactive({
    players <- players %>%
      filter(rating >= input$rating[1],
             rating <= input$rating[2])

    if (length(input$country) > 0) {
      players <- players %>%
        filter(nationality %in% input$country)
    }

    players
  })

  output$players_data <- renderDT({
    filtered_data()
  })

  output$num_players <- renderText({
    nrow(filtered_data())
  })

  output$fifa_plot <- renderPlot({
    p <- ggplot(filtered_data(), aes_string(input$variable)) +
      theme_classic() +
      scale_x_log10(labels = scales::comma)

    if (input$plot_type == "histogram") {
      p <- p + geom_histogram()
    } else if (input$plot_type == "density") {
      p <- p + geom_density()
    }
    p
  })

}

shinyApp(ui, server)
