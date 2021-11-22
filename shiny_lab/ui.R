library(shiny)
library(DT)


shinyUI(fluidPage(
    
    titlePanel('Shiny - Plots Interactivos'),
    fluidRow(
        plotOutput('plot_filter',
                   click = 'clk_filter',
                   dblclick = 'dclk_filter',
                   hover = hoverOpts('hover_filter', delay = 600),
                   brush = 'brush_filter')
    ),
    fluidRow(DT::dataTableOutput('mtcars_tbl'))
    
))