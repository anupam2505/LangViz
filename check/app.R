library(shiny)
library(radarchart)
choices <- c("Java", "MySQL", "C", "C++", "Python", "SQL", "JavaSript", "HTML", "MATLAB", "Swift")

temp <- read.csv("E:\\DV\\Project\\LangViz\\processedData\\language_common_topics.csv",sep=",")
my_func <- function(lang1, lang2) {
  # temp = read.csv("/Users/Roshni/Downloads/LanguageAnalysis-master/data/language_domain.csv", sep=",", row.names=1)
  temp1 <- as.matrix(temp)
  
  first_row_no<-which(temp1==lang1)
  second_row_no=which(temp1==lang2)
  my_row1<-temp1[which(temp1==lang1)]
  a<-as.vector(temp1[first_row_no,])
  b<-as.vector(temp1[second_row_no,])
  
  web_div1 <- as.numeric(a[2])/(as.numeric(a[2])+as.numeric(b[2]))*10
  database1 <- as.numeric(a[3])/(as.numeric(a[3])+as.numeric(b[3]))*10
  ds1 <- as.numeric(a[4])/(as.numeric(a[4])+as.numeric(b[4]))*10
  sys_div1 <- as.numeric(a[5])/(as.numeric(a[5])+as.numeric(b[5]))*10
  user_int1 <- as.numeric(a[6])/(as.numeric(a[6])+as.numeric(b[6]))*10
  
  web_div2 <- as.numeric(b[2])/(as.numeric(a[2])+as.numeric(b[2]))*10
  database2 <- as.numeric(b[3])/(as.numeric(a[3])+as.numeric(b[3]))*10
  ds2 <- as.numeric(b[4])/(as.numeric(a[4])+as.numeric(b[4]))*10
  sys_div2 <- as.numeric(b[5])/(as.numeric(a[5])+as.numeric(b[5]))*10
  user_int2 <- as.numeric(b[6])/(as.numeric(a[6])+as.numeric(b[6]))*10
  
  
  scores <- data.frame("Label"=c("Web Dev", "Database", "Data Science",
                                 "System Dev",  "User Interface"),
                       lang1 = c(web_div1,database1,ds1,sys_div1,user_int1),
                       lang2 = c(web_div2,database2,ds2,sys_div2,user_int2))
  
  scores[is.na(scores)]<-0  
  chartJSRadar(scores, maxScale = 10, showToolTipLabel=TRUE)
  
}

ui <- fluidPage(
  titlePanel("Select a language to explore user location densities"),
  fluidRow(column(2,
                  selectInput("val1", choices = choices, label = "Language 1",  selected = "Java" ),
                  selectInput("val2", choices = choices, label="Language 2", selected = "C++")),
           column(10,
                  chartJSRadarOutput("radar")
           )                              
  )
)

server <- function(input, output){ 
  output$radar <- renderChartJSRadar(my_func(as.character(tolower(trimws(input$val1))),as.character(tolower(trimws(input$val2))) ))
}

shinyApp(ui=ui, server = server)