library(shiny)
library(ssh)

options(shiny.maxRequestSize = 1000 * 1024^2)

ui <- fluidPage(
  fileInput("upload", "Upload a file"),
  tableOutput("files"),
  uiOutput("run_button"),
)

server <- function(input, output, session) {
  output$files <- renderTable(input$upload)
  
  output$run_button <- renderUI({
    div(
      actionButton("run_button", "Run SCP")
    )})
    
  observeEvent(input$run_button, {
    target_username = Sys.getenv('target_username')
    target_password = Sys.getenv('target_password')
    target_server = Sys.getenv('target_server')
    print(input$upload$datapath)
    
    # Connect to transfer server
    cat("Connecting to:", target_server, "...\n")
    ssh_transfer <- ssh_connect(paste0(target_username,"@",target_server), passwd = target_password, verbose = 4)
  
    # Transfer over RAW data
    scp_upload(ssh_transfer, input$upload$datapath)
    
    # Disconnect transfer server
    cat("Disconnecting from:", target_server, "...\n\n")
    ssh_disconnect(ssh_transfer)
  })
}


# Run the application 
shinyApp(ui = ui, server = server)
