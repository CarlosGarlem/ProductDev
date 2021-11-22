library(shiny)
library(dplyr)
library(ggplot2)


shinyServer(function(input, output, session) {
    
    datos <- reactiveVal(
        mtcars %>%
            mutate(point_color = 'default')
    )
    
    clicked_point <- reactiveVal(
        ''
    )
    
    
    observeEvent(input$hover_filter, {
        df <- datos()
        hovered <- row.names(nearPoints(df, input$hover_filter, xvar = 'wt', yvar = 'mpg'))
        df <- df %>%
            mutate(point_color = ifelse(row.names(df) %in% hovered, 'hovered', point_color))
        
        datos(df)
    })
    
    
    observeEvent(input$clk_filter, {
        df <- datos()
        clicked <- row.names(nearPoints(df, input$clk_filter, xvar = 'wt', yvar = 'mpg'))
        df <- df %>%
            mutate(point_color = ifelse(row.names(df) %in% clicked, 'clicked', point_color))
        
        datos(df)
        clicked_point(clicked)
    })
    
    
    observeEvent(input$dclk_filter, {
        df <- datos()
        dbclicked <- row.names(nearPoints(df, input$dclk_filter, xvar = 'wt', yvar = 'mpg'))
        df <- df %>%
            mutate(point_color = ifelse(row.names(df) %in% dbclicked, 'default', point_color))
        
        datos(df)
    })
    
    
    observeEvent(input$brush_filter, {
        df <- datos()
        brushed <- row.names(brushedPoints(df, input$brush_filter, xvar = 'wt', yvar = 'mpg'))
        df <- df %>%
            mutate(point_color = ifelse(row.names(df) %in% brushed, 'brushed', point_color))
        
        datos(df)
        clicked_point(brushed)
    })
    
    
    
    output$plot_filter <- renderPlot({
        color_palette <- c('clicked' = 'green'
                           , 'hovered' = 'darkgray'
                           , 'default' = 'black'
                           , 'brushed' = 'green')
        
        df <- datos()
        isolate({
            df %>%
                ggplot(aes(x = wt, y = mpg)) + 
                geom_point(aes(colour = point_color, size = 0.2)) +
                scale_color_manual(values = color_palette) +
                ylab('mpg') + 
                xlab('wt') + 
                ggtitle('wt vs mpg') + 
                theme_minimal()
        })                   
        
    })
    
    
    output$mtcars_tbl <- DT::renderDataTable({
        
        df <- mtcars
        clicked_point()
        isolate({
            clicked <- row.names(nearPoints(df, input$clk_filter, xvar = 'wt', yvar = 'mpg'))
            brushed <- row.names(brushedPoints(df, input$brush_filter, xvar = 'wt', yvar = 'mpg'))
            if((length(clicked) + length(brushed)) > 0){
                df <- df %>%
                    filter(row.names(df) %in% c(clicked, brushed))
            }
        })
        
        df
    })
    
})