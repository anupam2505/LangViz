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
    selectInput("countryinput2", label = "Select Language A:", choices = c(Choose='', as.character(lang2)), selectize = FALSE)
  }) 
  
  
  output$winbyyear <- renderChart({
    
    withProgress(message = "Rendering number of posts over years", {
      
      d1 = screencountry1winData()
      d2 = screencountry2winData()
      # Subset into top results
      d = rbind(d1,d2)
      p <- nPlot(Freq ~ year, group = 'country', type = 'lineChart', id = 'chart', dom = "winbyyear", data = d, height = 400, width = 450)
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
    matchesCountry2 = lang[lang$language=="c",]
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
  
  # Render total number of languages
  output$numStatesBox <- renderValueBox({
    valueBox(
      paste0(10), paste("Languages"), 
      icon = icon("keyboard-o"), color = "green"
    )
  })

  # Render total number of questions
  output$numCountiesBox <- renderValueBox({
    valueBox(
      paste0(1000), paste("Questions"), 
      icon = icon("question"), color = "yellow"
    )
  })

  # Render total number of answers
  output$numCitiesBox <- renderValueBox({
    valueBox(
      paste0(2500), paste("Answers"), 
      icon = icon("comments"), color = "red"
    )
  })
  
  # Render total number of users
  output$numZipsBox <- renderValueBox({
    valueBox(
      paste0(850), paste("Users"), 
      icon = icon("users"), color = "yellow"
    )
  })
  
  # Render Top 10 tags
  output$top10tfidf <- renderChart({
    current <- tfidf
    cur <- head(arrange(current,desc(tfidf)), n = 10)
    
    cur$tfidf <- round(cur$tfidf * 100,2)
    
    p <- nPlot(tfidf~keyphrase, data = cur, type = "discreteBarChart", dom = "top10tfidf")
    p$params$width <- 1000
    p$params$height <- 200
    p$xAxis(staggerLabels = TRUE)
    p$yAxis(axisLabel = "TFIDF * 100", width = 50)
    return(p)
  })
  
  # Render Top 10 topics
  output$top10CitiesBar <- renderChart({
    current <- tfidf
    cur <- head(arrange(current,desc(tfidf)), n = 10)
    
    cur$tfidf <- round(cur$tfidf * 100,2)
    p <- nPlot(tfidf~keyphrase, data = cur, type = "discreteBarChart", dom = "top10CitiesBar")
    p$params$width <- 1000
    p$params$height <- 200
    p$xAxis(staggerLabels = TRUE)
    p$yAxis(axisLabel = "TFIDF * 100", width = 50)
    return(p)
  })
  
  
  ## network plot
  output$networkPlot <- renderPrint({
    links <- tfidf
    
    nodes = data.frame("name" = unique(links[,1]))
    nodesnew = nodes
    nodes = rbind(nodes, data.frame("name" = links[,2]))
    links$source.index = match(links$language, nodes$name)-1
    
    links$target.index = match(links$keyphrase, nodes$name)-1
    
    links$group = links$source.index
    nodes1 = cbind(nodesnew,c(0,1,2,3,4,5,6,7,8,9) )
    colnames(nodes1) <- c( "name", "group")
    nodes2 = as.data.frame(cbind(links$keyphrase, links$group))
    colnames(nodes2) <- c( "name", "group")
    nodes2 = rbind(nodes1, nodes2)
    colnames(nodes2) <- c( "name", "group")
    nodes2 = as.data.frame(nodes2)
    d3ForceNetwork(Links = links, Nodes = nodes2,
                        Source = "source.index", Target = "target.index",
                        width = 1000, height = 600, Group = "group",
                        NodeID = "name", Value = 'tfidf', zoom = TRUE, parentElement = '#networkPlot',opacity = 0.9)
    
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
      lang1 <- Language_keywords[which(grepl(as.character(s[["x"]]), Language_keywords$Language, ignore.case = TRUE)),]
      lang2 <- Language_keywords[which(grepl(as.character(s[["y"]]), Language_keywords$Language, ignore.case = TRUE)),]
      common <- data.frame(rbind(lang1, lang2, make.row.names=FALSE))
      dup <- data.frame(name=common[which(duplicated(common$name)),]$name)
      #dup <- cbind(dup, data.frame(count=NA))
      if(nrow(dup)==0)
        bubbles(value = runif(26), label = LETTERS,
                color = rainbow(26, alpha=NULL)[sample(26)])
      else
      {
        dup$count <- sapply(dup$name, function(x){
          max(lang1[lang1$name==as.character(x),]$count, lang2[lang2$name==as.character(x),]$count)
        })
        
        bubbles::bubbles(value = dup$count, tooltip=dup$count,label = dup$name, color = rainbow(nrow(dup), alpha=NULL)[sample(nrow(dup))])
      } }
    
    else {
      bubbles(value = runif(26), label = LETTERS,
              color = rainbow(26, alpha=NULL)[sample(26)])
    }
  })
  
})