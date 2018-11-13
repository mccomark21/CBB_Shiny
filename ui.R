ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        tabPanel('Filters',
                 pickerInput(inputId = "picker",label = "Select College",choices = sort(unique(CBB_Data$College)),options = list(`actions-box` = TRUE,size = 10,`selected-text-format` = "count > 3"),selected= unique(CBB_Data$College), multiple = TRUE),
                 sliderInput("slider", "Year", min = min(CBB_Data$Year),  max = max(CBB_Data$Year), unique(CBB_Data$Year),step=1,sep="",value =  c(2003,2015)),
                 radioButtons("radio", "Draft Group", choices = unique(CBB_Data$Draft_Group), selected = unique(CBB_Data$Draft_Group)[1],inline = FALSE)
        )
      )
      
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Read Me",
                 h1("College Basketball Scoring Versatility Dashboard"),
                 hr(),
                 br(),
                 h4("All statistics provided are based on an individual player's college career and are on a 'Per Game' basis. Data ranges from the year 2003 - 2015."),
                 br(),
                 h4("Key Features:"),
                 strong("College:"),
                 h5("Last college player attended during career."),
                 strong("Year:"),
                 h5("Years available to set filter."),
                 strong("Draft Group:"),
                 h5("Lottery, selected within first 14 picks of draft."),
                 h5("Late 1st Round, selected between picks 15 to 30."),
                 h5("2nd Round, selected in second round of draft."),
                 strong("Points Per Game:"),
                 h5("Number of points scored per game by a player."),
                 strong("2P:"),
                 h5("Shots made within the 3 point arc."),
                 strong("3P:"),
                 h5("Shots made beyond the 3 point arc."),
                 strong("% of Points from Free Throws:"),
                 h5("Percentage of points made from free throws."),
                 strong("True Shooting Percentage:"),
                 h5("It is intended to more accurately calculate a player's shooting than field goal percentage, free throw percentage, and three-point field goal percentage taken individually. Two- and three-point field goals and free throws are all considered in its calculation. It is abbreviated TS%."),
                 tags$img(src='TS_Percent.png'),
                 br(),
                 tags$img(src='basket-ball-floor.png')
        ),
        tabPanel("Scatter Plot",
                 # h2("2P vs 3P"),
                 plotlyOutput("scat")
        ),
        tabPanel("Bar Chart",
                 # h2("Scoring vs FT Points"),
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