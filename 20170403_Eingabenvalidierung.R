# Vor Verwendung der App die Datei in "app.R" umbenennen!

library(shiny)

server <- function(input, output) {
  
  output$text_ergebnis_buchstabe <- renderText({
    # Pruefung, ob der eingegebene Wert nur Buchstaben enthaelt und nicht leer ist
    validate(
      need(grepl("^[A-Za-z]+$", input$text_buchstabe, perl = TRUE) & input$text_buchstabe != "", "Bitte Buchstaben eingegeben!")
    )
    paste0("Sie haben erfolgreich die Buchstaben ", input$text_buchstabe, " eingeben!")
  })
  
  output$text_ergebnis_zahl <- renderText({
    # Pruefung, ob der eingegebene Wert nur Zahlen enthaelt und nicht leer ist
    validate(
      need(grepl("^[0-9.]+$", input$text_zahl, perl = TRUE) & input$text_zahl != "", "Bitte Zahl eingegeben!")
    )
    paste0("Sie haben erfolgreich die Zahl ", input$text_zahl, " eingeben!")
  })
  
  output$text_ergebnis_select <- renderText({
    # Pruefung, ob der SelectInput gefuellt ist
    req(input$select_auswahl)
    paste0("Sie haben erfolgreich die ", input$select_auswahl, " gewählt!")
  })
}

ui <- fluidPage(
  titlePanel("Validierung von Eingaben"),
  br(), br(),
  
  sidebarLayout(
    sidebarPanel(
      textInput("text_buchstabe", "Bitte Buchstaben eingeben:"),
      textInput("text_zahl", "Bitte Zahl zw. 1 und 26 eingeben:"),
      selectInput("select_auswahl", "Bitte Option wählen:", choices = c("Option A"), selected = NULL, multiple = TRUE)
      
    ),
    mainPanel(
      wellPanel(
        verbatimTextOutput("text_ergebnis_buchstabe"),
        verbatimTextOutput("text_ergebnis_zahl"),
        verbatimTextOutput("text_ergebnis_select")
      )
    )
  )
)

shinyApp(ui = ui, server = server)
