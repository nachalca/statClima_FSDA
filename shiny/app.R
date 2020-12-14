
# bibliotecas, datos, funiones
#paquetes <- c("tidyverse","lubridate","dlm", 'shiny','knitr', 'shinymanager')
paquetes <- c("dplyr","tidyr","lubridate",'ggplot2',"dlm", 'shiny','knitr', 'shinymanager')

sapply(paquetes,require,character.only=T)
rm(paquetes)

# los datos con resultados de modelos
#ll <- readRDS(file = 'res_dlmbasico.rds')
ll <- readRDS(file = 'res_dlmbasico_nuevo.rds')

rrs <- ll$res.dlmbasico %>% mutate(day2 = yday(fecha)) %>% 
  dplyr::select(location, year, day2, fecha, tn.hat, tx.hat) %>% 
  gather(tipo, temp, tn.hat, tx.hat )

# funciones para hacer dibujos
imputemp_plot <- function(rr, start, per, locs, serie) { 
  #start: int, anio de incicio
  #per: int, cantidad de anios a mostrar
  #rr: df, los datos
  #locs: ch, estaciones a dibujar
  #serie: ch, minimas o maximas 
  if (serie == 'max') {
    temp = sym('tx')
    temp.hat = sym('tx.hat')
  }
  if (serie == 'min') {
    temp = sym('tn')
    temp.hat = sym('tn.hat')
    temp = 'tn'
    temp.hat = 'tn.hat'
  }
  
  rr %>%
    filter( fecha > make_date(start, 1, 1), fecha < make_date(start+per, 12, 1),
            location %in% locs) %>%
    ggplot( ) +
    geom_line(aes_string("fecha", temp.hat), color='red') +
    #geom_line(aes(fecha, yhat2), color='blue') +
    geom_line(aes_string("fecha", temp))  +
    facet_wrap(~location)
}

olas_plot <- function(rr, locs, yy) {
  # locs: estacion
  # yy: año de referencia
  rr1 <- filter(rr, location == locs )
  pl1 <- rr1 %>% ggplot() + geom_hex( aes(x=day2, y=temp) ) 
  
  pl1 + geom_line(data=filter(rr1, year==yy), 
              aes(x=day2, y=temp, group=tipo) )+
    facet_grid(tipo~., scales = 'free_y') +
    scale_fill_gradient(name='Frequence', high = '#034e7b', low = '#f1eef6') +
    theme_bw()
  
  #ggplotly(pl) %>%  layout(dragmode = "select")
}

estanzuela_eror_plot <- function(rr, start, per, locs, serie) { 
  #start: int, anio de incicio
  #per: int, cantidad de anios a mostrar
  #rr: df, los datos
  #locs: ch, estaciones a dibujar
  #serie: ch, minimas o maximas
  if (serie == 'max') {
    temp = sym('tx')
    temp.hat = sym('tx.hat')
  }
  if (serie == 'min') {
    temp = sym('tn')
    temp.hat = sym('tn.hat')
    temp = 'tn'
    temp.hat = 'tn.hat'
  }
  
  rr %>%
    filter( fecha > make_date(start, 1, 1), fecha < make_date(start+per, 12, 1),
            location == 'Estanzuela') %>%
    ggplot( ) +
    geom_line(aes_string("fecha", temp.hat), color='red') +
    #geom_line(aes(fecha, yhat2), color='blue') +
    geom_line(aes_string("fecha", temp))  +
    facet_wrap(~location)
}

# archivo con descripcion de la app
# rmdfiles <- c("describe_app.Rmd",'describe_dlm.Rmd','olas_de_extremos.Rmd')
# sapply(rmdfiles, knit, quiet = T)

rmdfiles <- c("describe_app",'describe_dlm','olas_de_extremos')
sapply(rmdfiles, function(x) knit(paste('describe/', x ,'.Rmd',sep=''),paste('describe/', x ,'.md',sep=''), quiet = T) )

# agrego clave para acceder a la app
credentials <- data.frame(
  user = c("temp"),
  password = c("temp"),
  stringsAsFactors = FALSE
)


#============================================================
# Arranca la app
# Define UI  --------------
ui <- #secure_app
( fluidPage(
  
  # App title ----
  titlePanel("Series Imputadas"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(width = 3,
                 conditionalPanel(condition = "input.tabsetpanel==4",
                                  img(src="Inumet_Imagotipo_negativo.jpg",height='100px',width='100px'),
                                  # img(src="fcea.png",height='100px',width='100px'),
                                  # img(src="iesta.png",height='100px',width='100px'),
                                  # img(src="udelar.png",height='100px',width='100px')
                                  img(src="logo IESTA FCEA UDELAR a color.JPG",height='100px',width='300px')
                              
                 ),
                 
      conditionalPanel(condition = "input.tabsetpanel==1",
                       
                       numericInput(inputId = "ola.yy",
                                    label = "Año",
                                    value = 1962),
                       
                       selectInput(inputId = "ola.loc",
                                   label = "Estaciones",
                                   choices = unique(ll$res.dlmbasico$location),
                                   multiple = FALSE,
                                   selected = 'Estanzuela')
                       ),
      
      
      conditionalPanel(condition = "input.tabsetpanel==2",
                       h4('Estanzuela'),
                       # Input: Slider for the number of bins ----
                       numericInput(inputId = "st",
                                    label = "Año inicial",
                                    value = 1962),
                       
                       numericInput(inputId = "pr",
                                    label = "Cantidad de años",
                                    value = 1),
                       
                       selectInput(inputId = "sr",
                                   label = "Serie",
                                   choices = c('min', 'max'),
                                   selected = 'min')
      ),
      
      conditionalPanel(condition = "input.tabsetpanel==3",
                       # Input: Slider for the number of bins ----
                       numericInput(inputId = "st2",
                                    label = "Año inicial",
                                    value = 1962),
                       
                       numericInput(inputId = "pr2",
                                    label = "Cantidad de años",
                                    value = 1),
                       
                       selectInput(inputId = "loc2",
                                   label = "Estaciones",
                                   choices = unique(ll$res.dlmbasico$location),
                                   multiple = TRUE,
                                   selected = 'Estanzuela'),
                       
                       selectInput(inputId = "sr2",
                                   label = "Serie",
                                   choices = c('min', 'max'),
                                   selected = 'min')
                       )
      

    ),
    
    # Main panel for displaying outputs ----
    mainPanel(width = 9,
              tabsetPanel(
                type = "tabs",
                id = "tabsetpanel",
      # paneles 
      tabPanel(
        title = "Describe",
        value = 4,
        withMathJax(includeMarkdown("describe/describe_app.md"))
      ),
      
      tabPanel(
        title = "Marco teórico",
        value = 4,
        withMathJax(includeMarkdown("describe/describe_dlm.md"))
      ),
      
      tabPanel(
        title = "Olas de extremos",
        value = 1,
        plotOutput(outputId = "wavePlot"),
        withMathJax(includeMarkdown("describe/olas_de_extremos.md")),
        plotOutput(outputId = "wavePlot2")
        #plotlyOutput(outputId = "wavePlot")
        
        ),
      tabPanel(
        title = "Estanzuela",
        value = 2, 
        plotOutput(outputId = "estanPlot")
        #plotOutput(outputId = "estanError")
      ),
      tabPanel(
        title = "Series Imputadas",
        value = 3, 
        plotOutput(outputId = "distPlot")
        )
    )
  )
)
)
)
#====================================================
#====================================================
#====================================================

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  #result_auth <- secure_server(check_credentials = check_credentials(credentials))
  
  output$res_auth <- renderPrint({
    reactiveValuesToList(result_auth)
  })
  
  # plot tab 1
  output$wavePlot <- renderPlot( {
    olas_plot(
      rr = rrs, 
      locs = input$ola.loc,
      yy = input$ola.yy
    )
  })
  
  # eh
  output$wavePlot2 <- renderPlot( {
    olas.estanz.hat <- filter(ll$res.dlmbasico, location == input$ola.loc) %>% 
      with( olas_fn(D=day(fecha), M=month(fecha), Y=year, Tx=tx.hat, Tn=tn.hat)  ) %>% 
      as_tibble() 
    
    olas.estanz.hat %>% mutate(dia=yday(make_date(Y,M,D))) %>% 
      mutate(olas=case_when( ola.frio>0 ~ "frio", ola.calor>0 ~ "calor", TRUE ~ "nada" )) %>% 
      filter(olas!="nada") %>% 
      ggplot(aes(y=Y,x=dia,col=olas))+geom_point()+theme_bw()+ylab("Año")+xlab("Día del año")+scale_x_continuous(breaks=seq(1,365,length.out = 24),labels=paste0(c(1,15),"/",rep(sprintf("%02d",1:12),each=2)))+theme(axis.text.x = element_text(size=5))+facet_wrap(~olas,nrow = 2)
      })
  
  
  
    # plot tab 2
  output$estanPlot <- renderPlot({
    imputemp_plot(
      rr = ll$res.dlmbasico, 
      start = input$st,
      per = input$pr,
      locs = 'Estanzuela',
      serie = input$sr
    )
  })
  
  
  # plot tab 3
  output$distPlot <- renderPlot({
      imputemp_plot(
      rr = ll$res.dlmbasico, 
      start = input$st2,
      per = input$pr2,
      locs = input$loc2,
      serie = input$sr2
    )
  })
  

  
}


shinyApp(ui = ui, server = server)