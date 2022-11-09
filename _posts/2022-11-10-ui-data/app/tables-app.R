# load libraries ----
library(data.table)
library(datamods)
library(rhandsontable)
library(shinythemes) 
library(shiny)

# load resources ----
source("./mods/mod-edit.R")
source("./global.R")

# full application ----
ui <- navbarPage("Data transformation interface",fluid=FALSE,theme = shinytheme("yeti"),
        
         # panel to load data
         tabPanel("Load",
            sidebarLayout(
              sidebarPanel = sidebarPanel(
                helpText(HTML("Load data from global environment using datamod package, import-globalenv (also allows data to be loaded from packages).
                              Other options include: <br/><br/>
                              <ul><li> import-file - supports .csv, .txt, .xls, .xlsx, .rds, .fst, .sas7bdat, .sav from fileserver </li><li>
                              import-copypaste - paste a list, dataframe or csv </li><li>
                              import-googlesheets - supports .csv, .txt, .xls, .xlsx, .rds, .fst, .sas7bdat, .sav from fileserver</li><li>
                              import-url - supports link to JSON</li><li>
                              import-modal - displays the module in modal.</li></ul>
                              A module not considered here is 'validation', which checks that a dataset meets some validation expectations."))
                ),
              mainPanel = mainPanel(
                import_globalenv_ui("file_import",
                                title = h3("Load data"),
                                globalenv = TRUE
                                ),
                verbatimTextOutput(outputId = "name"),
                verbatimTextOutput(outputId = "data")
              )
            )
         ),
         
         # panel to transform tables
         tabPanel("Transform",
            sidebarLayout(
              sidebarPanel = sidebarPanel(
                helpText(HTML("Transform loaded data (see prior tab) using datamod package (update-variables) by allowing edits to: <br/><br/> 
                        <ul><li> column name </li><li>
                        data type. </li></ul>"))
              ),
              mainPanel = mainPanel(
                update_variables_ui("file_update", 
                                    h3("Transform data")
                                    ),
                h3("Updated data"),
                br(),
                verbatimTextOutput(outputId = "updated_str")
                )
            )
         ),
         
         # panel to edit data
         tabPanel("Edit",
            sidebarLayout(                  
              sidebarPanel = sidebarPanel(
                helpText(HTML("Using rhandsontable package, edit the contents of a table by: <br/><br/> 
                              <ul><li> Right-click on the table to delete/insert rows </li><li>
                              Double-click on a cell to edit. </li></ul>
                              Edited data in this tab is not saved, but saving edited dataframes is possible.")),
                
                # listing dataframes
                wellPanel(
                  h3("Select table"),
                  br(),
                  selectInput(
                    inputId = "tableName", label = HTML("Select from tables in the global environment: <br/><br/>
                    <ul><li> eg_types - demos editing different data types </li><li>
                    eg_mapping - demos editing NAs into text groupings </li></ul>"),
                    selected = NULL, multiple = FALSE,
                    choices = choice_list),
                  # edit choices
                  h3("Edit options"),
                  radioButtons(
                    inputId = "table_edit_type", label = HTML("Tailor editing to data type? <br/><br/>"), 
                    c("TRUE", "FALSE"))
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
  
  imported <- import_globalenv_server("file_import",
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
  
  updated <- update_variables_server("file_update", df_upload, height = NULL)
  
  output$modified <- renderPrint({
    updated()
  })
  output$updated_str <- renderPrint({
    str(updated())
  })
  
  # handsontable
 table_edit_server("table_for_edit", 
                  vbl = "table_for_edit", 
                  df = reactive(get(input$tableName)), 
                  table_edit_type = reactive(as.logical(input$table_edit_type)), 
                  threshhold = 10)
  
}

shinyApp(ui, server)


