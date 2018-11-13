server <- function(input, output, session) {
  filtered_data <- reactive({filter(CBB_Data, College %in% input$picker,Year >= input$slider[1] & Year <= input$slider[2], Draft_Group==input$radio)})
  
  output$scat <- renderPlotly(
    {
      p <- ggplot(filtered_data(), aes(x = `Per Game 3P`,y = `Per Game 2P`, Player = Player, color = `TS%`))+
        geom_point()+
        labs(title = "2P Shots vs 3P Shots", x = "3P Made Per Game", y = "2P Made Per Game", color = "Legend\n")+
        scale_color_gradientn(colours = c("darkblue","lightblue","yellow","orange","red"),
                              values = c(1.0,0.8,0.6,0.4,0.2,0))+
        theme_bw()
      
      ggplotly(p, tooltip = c("Player","x","y","TS%"))    
    }
  )
  output$bar <- renderPlotly(
    {
      b <- ggplot(head(arrange(filtered_data(),desc(`Per Game PTS`)),5), aes(x = reorder(Player,-`Per Game PTS`))) +
        geom_col(aes( y = `Per Game PTS`, fill = '')) +
        geom_text(aes(y = `Per Game PTS`, label = `Per Game PTS`), fontface = "bold", vjust = 1.4, color = "black", size = 4) +
        geom_line(aes(y = FT_Points, group = 1, color = '')) +
        geom_text(aes(y = FT_Points, label = round(FT_Points, 2)), vjust = 1.4, color = "black", size = 4) +
        scale_fill_manual('',labels = 'Points Per Game', values = 'seagreen3') + # change bar colors
        scale_color_manual('',labels = 'FT Point %', values = 'black')+
        labs(title = "Top Scorer VS % of Points From Free Throws\n", x = "Top 5 Scorers", y = "Points Per Game", color = "Legend\n")+
        theme_bw()+
        theme(axis.text.x=element_text(angle=90,hjust=1))
      
      ggplotly(b)
    }
  )
  output$table <- renderDataTable(
    {
      select(filtered_data(),c("Year","Pk","Tm","Player","College","G",`Per Game 2P`,"Per Game 3P",`Per Game PTS`))
    }
  )
}