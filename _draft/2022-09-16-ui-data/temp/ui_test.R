library(shiny)
library(ggplot2)  
library(bslib)
library(datamods)
library(shinythemes)

#https://cran.r-project.org/web/packages/datamods/vignettes/datamods.html
#https://dreamrs.github.io/datamods/ - datamods package for editing data
#https://shiny.rstudio.com/gallery/widget-gallery.html - widgets
#https://davidbarke.shinyapps.io/shinyplyr/ - data transformations
#https://community.rstudio.com/t/editable-datatables-in-r-shiny-using-sql/81401 - editable table
#https://community.rstudio.com/t/shiny-contest-submission-table-editor-shiny-app/23600 - editable table

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
    column(width = 4,
    import_file_ui("myid")
    ),
    column(width = 8,
    tags$b("Imported data:"),
    verbatimTextOutput(outputId = "status"),
    verbatimTextOutput(outputId = "data")
    )
  )
  
)

server <- function(input, output) {
  
  # increase max upload size to 50mb
  options(shiny.maxRequestSize=30*1024^2)
  
  imported <- import_file_server("myid")

  output$status <- renderPrint({
    imported$status()
  })
  output$data <- renderPrint({
    imported$data()
  })
  
}

shinyApp(ui, server)