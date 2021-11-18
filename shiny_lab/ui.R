library(shiny)
library(DT)


shinyUI(fluidPage(
    
    titlePanel('Shiny - Plots Interactivos'),
    tabsetPanel(
        tabPanel('Color Plot',
                 plotOutput('plot_click_options',
                            click = 'clk',
                            dblclick = 'dclk',
                            hover = 'mouse_hover',
                            brush = 'mouse_brush')
        )
        ,
        tabPanel('Filtrando con plots',
                 fluidRow(
                     column(6, 
                            plotOutput('plot_filter',
                                       click = 'clk_filter',
                                       brush = 'brush_filter'),
                     ),
                     column(6, DT::dataTableOutput('mtcars_tbl'))
                 )
        )
    )
    
))