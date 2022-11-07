# load libraries ----
library(data.table)
library(datamods)
library(rhandsontable)
library(shinythemes) 
library(shiny)

# load resources ----
source("./mods/mod-edit.R")

# create data for mappings ----

eg_types <- data.frame(val = 1:10, bool = TRUE, big = LETTERS[1:10],
                small = letters[1:10],
                dt = seq(from = Sys.Date(), by = "days", length.out = 10),
                stringsAsFactors = FALSE)
eg_mapping <- data.frame(val = 1:10, desc = NA_character_,
                        stringsAsFactors = FALSE)

# full application ----
ui <- navbarPage("Data transformation interface",fluid=FALSE,theme = shinytheme("yeti"),
        
         # panel to load data
         tabPanel("Load",
            sidebarLayout(
              sidebarPanel = sidebarPanel(
                helpText("Load data from fileserver.")
                ),
              mainPanel = mainPanel(
                import_file_ui("file_import",
                                title = h3("Load data"),
                                preview_data = TRUE,
                                file_extensions = c(".csv", ".txt", ".xls", ".xlsx", ".rds")
                ),
                
                verbatimTextOutput(outputId = "name"),
                verbatimTextOutput(outputId = "data")
              )
            )
         ),
         
         # panel to transform tables
         tabPanel("Transform",
                splitLayout(
                update_variables_ui("file_update", 
                                    h3("Transform data")
                                    )
                )
         ),
         
         # panel to edit data
         tabPanel("Edit",
            sidebarLayout(                  
              sidebarPanel = sidebarPanel(
                helpText(HTML("Shiny app based on an example given in the rhandsontable package.<br/><br/> 
                              Right-click on the table to delete/insert rows. <br/><br/>
                              Double-click on a cell to edit.")),
                
                # Listing DFs
                wellPanel(
                  h3("Select table"),
                  selectInput(
                    inputId = "tableName", label = HTML("Select from tables in the global environment. <br/><br/>
                    eg_types demos editing different data types, eg_mapping demos editing NAs into text groupings <br/><br/>"),
                    selected = NULL, multiple = FALSE,
                    choices = c(ls()[sapply(ls(), function(x) class(get(x))) == 'data.frame'])),
                    
                  h3("Edit options"),
                  radioButtons(
                    inputId = "table_edit_type", label = HTML("Tailor to data type <br/><br/>"), 
                    c("TRUE", "FALSE")),
                )
              ),
              mainPanel = mainPanel(
                h3("Edit data in table"),
                table_edit_ui("table_for_edit")
              )
            )
         )
)

server <- function(input, output, session) {

  # increase max upload size
  options(shiny.maxRequestSize=30*1024^2)
  
  imported <- import_file_server("file_import",
                                 btn_show_data = FALSE,
                                 show_data_in = c("popup", "modal"),
                                 trigger_return = "button",
                                 return_class = "data.frame",
                                 reset = reactive(NULL))
  
  output$name <- renderPrint({
    req(imported$name())
    imported$name()
  })
  
  output$data <- renderPrint({
    req(imported$data())
    str(imported$data())
  })
  
  df_upload <- reactive({
    imported$data()
  })
  
  update_variables_server("file_update", df_upload, height = NULL)
  
  # handsontable
  table_edit_server("table_for_edit", 
                    vbl = "table_for_edit", 
                    df = reactive(get(input$tableName)), 
                    table_edit_type = reactive(as.logical(input$table_edit_type)), 
                    threshhold = 10)
  
}
shinyApp(ui, server)
