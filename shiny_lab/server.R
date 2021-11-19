library(shiny)
library(dplyr)
library(ggplot2)


shinyServer(function(input, output, session) {
    
    datos <- reactiveVal(
        mtcars %>%
            mutate(point_color = 'default')
    )
    
    
    plotData <- reactive({
        df <- datos()
        hovered <- row.names(nearPoints(df, input$mouse_hover, xvar = 'wt', yvar = 'mpg'))
        clicked <- row.names(nearPoints(df, input$clk, xvar = 'wt', yvar = 'mpg'))
        dbclicked <- row.names(nearPoints(df, input$dclk, xvar = 'wt', yvar = 'mpg'))
        brushed <- row.names(brushedPoints(df, input$mouse_brush, xvar = 'wt', yvar = 'mpg'))
        
        df <- df %>%
            mutate(point_color = ifelse(row.names(df) %in% hovered, 'hovered', point_color)) %>%
            mutate(point_color = ifelse(row.names(df) %in% clicked, 'clicked', point_color)) %>%
            mutate(point_color = ifelse(row.names(df) %in% dbclicked, 'default', point_color)) %>%
            mutate(point_color = ifelse(row.names(df) %in% brushed, 'brushed', point_color))
        
        datos(df)
        datos()
    })
    
    
    output$plot_click_options <- renderPlot({
        color_palette <- c('clicked' = 'green'
                           , 'hovered' = 'darkgray'
                           , 'default' = 'black'
                           , 'brushed' = 'blue')
        
        
        plotData() %>%
            ggplot(aes(x = wt, y = mpg)) +
            geom_point(aes(colour = point_color, size = 0.20)) +
            scale_color_manual(values = color_palette) +
            ylab('wt') + 
            xlab('mpg') + 
            ggtitle('wt vs mpg') + 
            theme_classic()
        
    })
    
    
    output$plot_filter <- renderPlot({
        mtcars %>%
            ggplot(aes(x = wt, y = mpg)) + 
            geom_point() + 
            ylab('wt') + 
            xlab('mpg') + 
            ggtitle('wt vs mpg') + 
            theme_minimal()
        
    })
    
    
    output$mtcars_tbl <- DT::renderDataTable({
        df <- mtcars
        clicked <- row.names(nearPoints(df, input$clk_filter, xvar = 'wt', yvar = 'mpg'))
        brushed <- row.names(brushedPoints(df, input$brush_filter, xvar = 'wt', yvar = 'mpg'))
        
        if((length(clicked) + length(brushed)) > 0){
            df <- df %>%
                filter(row.names(df) %in% c(clicked, brushed))
        }
        
        df
    })
    
})