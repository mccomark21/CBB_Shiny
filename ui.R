ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel('Filters',
                 pickerInput(inputId = "picker",label = "Select College",choices = unique(CBB_Data$College),options = list(`actions-box` = TRUE,size = 10,`selected-text-format` = "count > 3"),selected= unique(CBB_Data$College), multiple = TRUE),
                 sliderInput("slider", "Year", min = min(CBB_Data$Year),  max = max(CBB_Data$Year), unique(CBB_Data$Year),step=1,sep="",value =  c(2003,2015)),
                 radioButtons("radio", "Draft Group", choices = unique(CBB_Data$Draft_Group), selected = unique(CBB_Data$Draft_Group)[1],inline = FALSE)
        )
      )
      
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Read Me",
                 h2("College Basketball Scoring Versatility Dashboard"),
                 h4("This dashaboard provides...")
        ),
        tabPanel("Scatter Plot",
                 h2("2P vs 3P"),
                 plotlyOutput("scat")
        ),
        tabPanel("Bar Chart",
                 h2("Scoring vs FT Points"),
                 plotlyOutput("bar")
        ),
        tabPanel("Data Table",
                 h2("Data Table"),
                 dataTableOutput(outputId = "table")
        )        
      )
      
    )
  )
  
  
)