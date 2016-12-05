# LangViz
# Anupam Panwar
# Date: September 29, 2016

# server.R

#===============================================================================
#                               SHINYSERVER                                    #
#===============================================================================

shinyServer(function(input, output, session) {
  
  #===============================================================================
  #                        DASHBOARD SERVER FUNCTIONS                            #
  #===============================================================================
 #which language
  output$usViBox <- renderValueBox({
    current <- languages[ which(languages$Language == "java"), ]
    valueBox(
      paste0( current$Language), paste(" Current Language "), 
      icon = icon("keyboard-o"), color = "green"
    )
  })
  
  # Number of Users
  output$highestViBox <- renderValueBox({
    current <- languages[ which(languages$Language == "java"), ]
    valueBox(
      paste0(current$Questions), paste("Total questions related to this language "), 
      icon = icon("question"), color = "blue"
    )
  })
  
  
  
  ## Select one language
  output$Lang1Query4Ui <- renderUI({
    lang1 = unique(sort(lang$language))
    # country1 = sort(unique(matches$country1))
    selectInput("countryinput1", label = "Select Language A:", choices = c(Choose='', as.character(lang1)), selectize = FALSE)
  }) 
  
  ## Select second language
  output$Lang2Query4Ui <- renderUI({
    lang2 = unique(sort(lang$language))
    # country1 = sort(unique(matches$country1))
    selectInput("countryinput2", label = "Select Language B:", choices = c(Choose='', as.character(lang2)), selectize = FALSE)
  }) 
  
  
  output$winbyyear <- renderChart({
    
    withProgress(message = "Rendering number of posts over years", {
      
      d1 = screencountry1winData()
      d2 = screencountry2winData()
      # Subset into top results
      d = rbind(d1,d2)
      p <- nPlot(Freq ~ year, group = 'country', type = 'lineChart', id = 'chart', dom = "winbyyear", data = d, height = 400, width = 700)
      p$chart(color = c('blue', 'red'))
      p$yAxis( axisLabel = "Wins" )
      p$xAxis( axisLabel = "Year" )
      return(p)
    })
  })
  
  
  # Get lang1 win data
  screencountry1winData <-eventReactive(input$query1,{
    # Get Deta
    xyz = input$countryinput1
    matchesCountry1 = lang[lang$language==xyz,]
    count1 = aggregate(matchesCountry1$answer_count, by=list(Category=matchesCountry1$year), FUN=sum)
    
    
    colnames(count1) <- c( "year", "Freq")
    count1$country <- rep(xyz,nrow(count1))
    return(count1)
  }, ignoreNULL = FALSE)
  
  
  # Get lang2 win data
  screencountry2winData <-eventReactive(input$query1, {
    in2 = input$countryinput2
    matchesCountry2 = lang[lang$language==in2,]
    count2 = aggregate(matchesCountry2$answer_count, by=list(Category=matchesCountry2$year), FUN=sum)
    
    
    colnames(count2) <- c( "year", "Freq")
    count2$country <- rep(in2,nrow(count2))
    return(count2)
  }, ignoreNULL = FALSE)
  
  
  
  # Number of answers
  output$usAnnualBox <- renderValueBox({
    current <- languages[ which(languages$Language == "java"), ]
    valueBox(
      paste0(current$Answers), paste("Total answers related to this language "), icon = icon("comments"), color = "red"
    )
  })
  
  # Render Highest Annual Price Growth  Box
  output$highestAnnualBox <- renderValueBox({
    current <- languages[ which(languages$Language == "java"), ]
    valueBox(
      paste0(current$Users), paste("Total users questioned or answered on this language "), 
      icon = icon(""), color = "purple"
    )
  })
  
  ## Landing page info box
  output$infobox <- renderValueBox({
    valueBox(
      paste("Best career paths based on trending technologies and languages."), 
      icon = icon("info"), color = "orange"
    )
  })
  
  # Render total number of languages
  output$numStatesBox <- renderValueBox({
    valueBox(
      paste0(9), paste("Languages"), 
      icon = icon("keyboard-o"), color = "green"
    )
  })

  # Render total number of questions
  output$numCountiesBox <- renderValueBox({
    valueBox(
      paste0(4594711), paste("Questions"), 
      icon = icon("question"), color = "yellow"
    )
  })

  # Render total number of answers
  output$numCitiesBox <- renderValueBox({
    valueBox(
      paste0(8095024), paste("Answers"), 
      icon = icon("comments"), color = "red"
    )
  })
  
  # Render total number of users
  output$numZipsBox <- renderValueBox({
    valueBox(
      paste0(56033), paste("Users"), 
      icon = icon("users"), color = "yellow"
    )
  })
  
  ### Salary Bases
  output$top10tfidf <- renderPlotly({
    salary_by_occupation = salary_by_occupation[order(salary_by_occupation$Average_Salary_per_annum),]
    p <- plot_ly(salary_by_occupation, y = ~Average_Salary_per_annum, x= ~Occupation, text = ~Languages, color = ~Occupation, size = ~Satisfaction, type = 'scatter', mode = 'markers') %>%
      layout(
        xaxis = list(zeroline = TRUE,
                     showline = TRUE,
                     mirror = "ticks",
                     showgrid = FALSE),
        yaxis = list(zeroline = TRUE,
                     showline = TRUE,
                     mirror = "ticks",
                     showgrid = FALSE), showlegend = FALSE)
  
    return(p)
  })
  
  
  

  
  # Trending technology in 2016
  output$trendingtech <-renderPlotly({
    abc = stack_survey %>%
      inner_join(stack_multi("tech_do")) %>%
      group_by(answer) %>%
      summarize_each(funs(mean(., na.rm = TRUE)), age_midpoint, salary_midpoint) 
    colnames(abc) = c("Technology", "Average_Age", "Average_Salary")
      
    p <- plot_ly(abc, x = ~Average_Age, y= ~Average_Salary, size = 0.1, color = ~Technology,   type = 'scatter', mode = 'markers') %>%
      layout(
             xaxis = list(zeroline = TRUE,
                          showline = TRUE,
                          mirror = "ticks",
                          showgrid = FALSE),
             yaxis = list(zeroline = TRUE,
                          showline = TRUE,
                          mirror = "ticks",
               showgrid = FALSE), showlegend = FALSE)
    
    return(p)
  })
  
  
  ## network plot
  output$networkPlot <- renderForceNetwork({
    links <- tfidf1
    #links$count = rep(10,length(links))
    nodes = data.frame("name" = unique(links[,1]))
    nodesnew = nodes
    nodes = rbind(nodes, data.frame("name" = links[,2]))
    links$source.index = match(links$language, nodes$name)-1
    
    links$target.index = match(links$tag, nodes$name)-1
    
    links$group = links$source.index
    nodes1 = cbind(nodesnew,c(0,1,2,3,4,5,6,7,8,9), c(100,100,100,100,100, 100,100,100,100,100) )
    colnames(nodes1) <- c( "name", "group", "nodesize")
    nodes2 = as.data.frame(cbind(links$tag, links$group, rep(5,length(links) )))
    colnames(nodes2) <-  c( "name", "group", "nodesize")
    nodes2 = rbind(nodes1, nodes2)
    colnames(nodes2) <-  c( "name", "group", "nodesize")
    nodes2 = as.data.frame(nodes2)
    
    forceNetwork(Links = links, Nodes = nodes2,
                   Source = "source.index", Target = "target.index",fontSize = 20,
                   Group = "group", Value = "count1",Nodesize = "nodesize",
                   NodeID = "name",  zoom = TRUE,opacity = 0.9)
    
      # d3ForceNetwork(Links = links, Nodes = nodes2,
      #                     Source = "source.index", Target = "target.index",
      #                     width = 700, height = 600, Group = "group", Value = "count1",
      #                     NodeID = "name",  zoom = TRUE, parentElement = '#networkPlot',opacity = 0.9)
    
  })
  
  
  #### Compare All
  
  output$heat <- renderPlotly({
    plot_ly(x=nms, y=nms, z=sim, key=sim, colors ="Blues", type = "heatmap") %>%
      layout(xaxis = list(title = ""), 
             yaxis = list(title = ""))
  })
  
  output$bubble <- bubbles::renderBubbles({
    s <- event_data("plotly_click")
    if (length(s)) {
      vars <- c(s[["x"]], s[["y"]]) # s[["x"]] and s[["y"]] are lang1 and lang2
      library(bubbles)
      if(as.character(s[["x"]])!=as.character(s[["y"]]))
      {  
        combo1 <- paste(as.character(tolower(s[["x"]])),"-",as.character(tolower(s[["y"]])), sep="")
        combolang1 <- Language_keywords2[Language_keywords2$language_pair==combo1,]
        combo2 <- paste(as.character(tolower(s[["y"]])),"-",as.character(tolower(s[["x"]])), sep="")
        combolang2 <- Language_keywords2[Language_keywords2$language_pair==combo2,]
        combolang <- data.frame(rbind(combolang1, combolang2, make.row.names=FALSE))
        yrPal <- colorRampPalette(c("#E0F7FA", "#00ACC1"))
        if(nrow(combolang)==0)
          bubbles(value = runif(26), label = LETTERS,
                  color = yrPal(26)[runif(26),breaks = 8])
        else
        {
          yrPal <- colorRampPalette(c("#E0F7FA", "#00ACC1"))
          combolang$color <- yrPal(10)[as.numeric(cut(combolang$count,breaks = 8))]
          bubbles::bubbles(value = combolang$count, tooltip=combolang$count,label = combolang$topic, color = combolang$color)
        }
      }
      else 
      {
        #Tags for each language
        lang <- Language_keywords[which(grepl(as.character(s[["x"]]), Language_keywords$Language, ignore.case = TRUE)),]
        yrPal <- colorRampPalette(c("#E0F7FA", "#00ACC1"))
        lang$color <- yrPal(10)[as.numeric(cut(lang$count,breaks = 10))]
        bubbles::bubbles(value = lang$count, tooltip=lang$count,label = lang$name, color = lang$color)
      }  
      
    }
    
    else {
      bubbles(value = runif(26), label = LETTERS,
              color = heat.colors(26, alpha=NULL)[sample(26)])
    }
  })
  
  
  ## Radar chart 
  
  radar_func <- function(lang1, lang2) {
    # temp = read.csv("/Users/Roshni/Downloads/LanguageAnalysis-master/data/language_domain.csv", sep=",", row.names=1)
    temp1 <- as.matrix(language_domain)
    
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
    
    colnames(scores) = c("Label", input$countryinput1, input$countryinput2)
    
    scores[is.na(scores)]<-0  
    chartJSRadar(scores, maxScale = 10, showToolTipLabel=TRUE)
    
  }
  
  ## radar main function
  output$radar <- renderChartJSRadar(radar_func(as.character(tolower(trimws(input$countryinput1))),as.character(tolower(trimws(input$countryinput2))) ))
  
  
  output$title <- renderPrint({
    
    s <- event_data("plotly_click")
    if (is.null(s)) "Click on a Similarity Matrix cell!" else
    {
      if(s[["x"]]==s[["y"]])
        paste("Top tags for ", trimws(s[["x"]]))
      else
        paste("Common tags between ", s[["x"]], " and ", s[["y"]])
      
    }
  })
  
  ## MAp
  output$map <- renderLeaflet({
    lang1markers <- mapdata[mapdata$Language==as.character(tolower(trimws(input$countryinput1))),]
    lang2markers <- mapdata[mapdata$Language==as.character(tolower(trimws(input$countryinput2))),]
    
    clusOptions1 = markerClusterOptions(iconCreateFunction=JS("function (cluster) {    
                                                              var childCount = cluster.getChildCount();  
                                                              if (childCount < 300) {  
                                                              c = 'rgba(179, 201, 217, 0.7);'
                                                              } else if (childCount < 600) {  
                                                              c = 'rgba(72, 158, 186, 0.7);'  
                                                              } else { 
                                                              c = 'rgba(22, 83, 110, 0.7);'  
                                                              }    
                                                              return new L.DivIcon({ html: '<div style=\"background-color:'+c+'\"><span>' + childCount + '</span></div>', className: 'marker-cluster', iconSize: new L.Point(40, 40) });
                                                              
  }"))
    clusOptions2 = markerClusterOptions(iconCreateFunction=JS("function (cluster) {    
                                                              var childCount = cluster.getChildCount();  
                                                              if (childCount < 300) {  
                                                              c = 'rgba(254, 208, 122, 0.7);'
                                                              } else if (childCount < 600) {  
                                                              c = 'rgba(254, 135, 37, 0.7);'  
                                                              } else { 
                                                              c = 'rgba(207, 59, 2, 0.7);'  
                                                              }    
                                                              return new L.DivIcon({ html: '<div style=\"background-color:'+c+'\"><span>' + childCount + '</span></div>', className: 'marker-cluster', iconSize: new L.Point(40, 40) });
                                                              
    }"))

    leaflet() %>% 
      addTiles() %>% 
      addCircleMarkers(lng= lang1markers$Longitude, lat= lang1markers$Latitude, clusterOptions = clusOptions1, color="Blue") %>% 
      addCircleMarkers(lng= lang2markers$Longitude, lat= lang2markers$Latitude, clusterOptions = clusOptions2, color="Red") %>%
      addLegend(colors=c("#b3c9d9","#489eba", "#16536e"), labels=c("<300", ">300 & <600", ">600"), title=paste(input$countryinput1, " Users"))%>%
      addLegend(colors=c("#fed07a","#fe8725", "#cf3b02"), labels=c("<300", ">300 & <600", ">600"), title=paste(input$countryinput2, " Users"))
})
  
  
  
  
  
})