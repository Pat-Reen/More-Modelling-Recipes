# edit module ----
table_edit_ui <- function(id) {
  
  rHandsontableOutput(NS(id, "table_for_edit"))
  
}

table_edit_server <- function(id, vbl, df, table_edit_type, threshhold) {
  
  moduleServer(id, function(input, output, session) {
    
    # handsontable
    output$table_for_edit <- renderRHandsontable({
      if (!is.null(df))
        rhandsontable(df(), useTypes = table_edit_type(), stretchH = "all")
    })
  })
}
