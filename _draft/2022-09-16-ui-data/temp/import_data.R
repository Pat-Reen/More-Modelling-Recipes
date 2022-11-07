library(shiny)
library(datamods)
library(bslib)
library(shinythemes)
library(data.table)

ui <- fluidPage(
  theme = bs_theme(version = 4, bootswatch = "lux"),
  titlePanel("Data transformation interface"),
  
  #navigation bar
  navbarPage("Header A",
             tabPanel("Component 1"),
             tabPanel("Component 2"),
             tabPanel("Component 3"),
             tabPanel("Component 4"),
             navbarMenu("Component 5"),
             tabPanel("Sub-Component A"),
  ),
  
  #column layout
  fluidRow(
    column(
      width = 10,
      import_file_ui(
        "file_import",
        title = TRUE,
        preview_data = TRUE,
        file_extensions = c(".csv", ".txt", ".xls", ".xlsx", ".rds", ".fst", ".sas7bdat", ".sav")
      )
    ),
    
    column(
      width = 8,
      tags$b("Imported data:"),
      verbatimTextOutput(outputId = "name"),
      verbatimTextOutput(outputId = "data")
    ),
    
    column(
      width = 10,
      update_variables_ui(
        "update_variables",
        title = TRUE
      )
    )
    
  )
  
)

server <- function(input, output, session) {
  # increase max upload size to 50mb
  options(shiny.maxRequestSize=30*1024^2)
  
  imported <- import_file_server(
    "file_import",
    btn_show_data = TRUE,
    show_data_in = c("popup", "modal"),
    trigger_return = c("button", "change"),
    return_class = c("data.frame", "data.table", "tbl_df"),
    reset = reactive(NULL),
    read_fns = list()
  )
  
  output$name <- renderPrint({
    req(imported$name())
    imported$name()
  })
  
  output$data <- renderPrint({
    req(imported$data())
    imported$data()
  })
  
  updated_data <- update_variables_server(
    id = "update_variables",
    data = reactive(imported$data)
  )
  
  
  output$modified <- renderPrint({
    updated_data()
  })
  output$modified_str <- renderPrint({
    str(updated_data())
  })
  
  
}

if (interactive())
  shinyApp(ui, server)
