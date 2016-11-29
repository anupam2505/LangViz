# LangViz
# Anupam Panwar
# Date: September 29, 2016

#ui.R

dashboardPage(skin = "green",
              dashboardHeader(title = "Language Analytics"),
              dashboardSidebar(
                sidebarMenu(id = "sbm",
                            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                            # menuItem("Explorer", tabName = "explorer", icon = icon("search")),
                            # conditionalPanel(
                            #   condition = "input.sbm == 'valueAnalysis' || input.sbm == 'trainModels' || input.sbm == 'compareModels' || input.sbm == 'forecast'",
                            #   uiOutput("stateUi"),
                            #   uiOutput("countyUi"),
                            #   uiOutput("cityUi"),
                            #   uiOutput("zipUi")
                            # ),
                            # menuItem("Value Analyzer", tabName = "valueAnalysis", icon = icon("area-chart")),
                            # menuItem("Visualization", tabName = "forecast", icon = icon("bar-chart")),
#                             menuItem("Languages", tabName = "Languages", icon = icon("question-circle"),
#                                      menuSubItem("Java", icon = icon("user"),tabName = "java"),
#                                      menuSubItem("MySQL", icon = icon("coffee"),tabName = "mysql"),
#                                      menuSubItem("C", icon = icon("coffee"),tabName = "c"),
#                                      menuSubItem("C++", icon = icon("coffee"),tabName = "c++"),
#                                      menuSubItem("Python", icon = icon("coffee"),tabName = "python"),
#                                      menuSubItem("SQL", icon = icon("coffee"),tabName = "sql"),
#                                      menuSubItem("Javascript", icon = icon("coffee"),tabName = "javascript"),
#                                      menuSubItem("HTML", icon = icon("coffee"),tabName = "html"),
#                                      menuSubItem("Matlab", icon = icon("coffee"),tabName = "matlab")
#                                      ),
                            menuItem("Comparitive Analyzer", tabName = "Comparitive", icon = icon("question-circle"),
                                     menuSubItem("Compare All", icon = icon("user"),tabName = "compareall"),
                                     menuSubItem("Compare Two", icon = icon("coffee"),tabName = "comparetwo")
                                     # menuSubItem("Dashboard", icon = icon("dashboard"),tabName = "helpDashboard"),
                                     # menuItem("Market Explorer", icon = icon("search"),
                                     #          menuSubItem("Build a Query", icon = icon("search"), tabName = "helpBuildQuery"),
                                     #          menuSubItem("Market Report", icon = icon("bar-chart"), tabName = "helpMarketReport")),
                                     # menuItem("Value Analyzer", icon = icon("area-chart"),
                                     #          menuSubItem("Non-Seasonal Series", icon = icon("line-chart"), tabName = "helpNonSeasonal"),
                                     #          menuSubItem("Seasonal Series", icon = icon("bar-chart"), tabName = "helpSeasonal")),
                                     # menuItem("Forecast Modeler", icon = icon("bar-chart"),
                                     #          menuSubItem("Set Parameters", icon = icon("caret-square-o-right"), tabName = "helpSetParameters"),
                                     #          menuSubItem("Analyze Models", icon = icon("gears"), tabName = "helpAnalyzeModels"),
                                     #          menuSubItem("Compare Models", icon = icon("check-circle"), tabName = "helpCompareModels")),
                                     # menuSubItem("Market Forecaster", icon = icon("line-chart"),tabName = "helpMarketForecaster")
                                     )
                )# end of sidebarMenu
              ),#end of dashboardSidebar
              
              dashboardBody(
                includeCSS("www/custom.css"),
                tabItems(
                  tabItem(tabName = "dashboard",
                          fluidPage(
                            title = "Dashboard",
                            tags$head(
                              tags$script(src = 'http://d3js.org/d3.v3.min.js')
                            ),
                            fluidRow(
                              column(width = 12,
                                     box(
                                       title = "Welcome to Language Analytics ! Explore best career paths based on trending technologies and languages. ",
                                       width = 12,
                                       height = 50,
                                       background = "green",
                                       solidHeader = TRUE,
                                       collapsed = TRUE
                                       )
                              )# end of column
                            ),
                            fluidRow(
                              column(width = 12,
                                     valueBoxOutput("numStatesBox", width = 3),
                                     valueBoxOutput("numCountiesBox", width = 3),
                                     valueBoxOutput("numCitiesBox", width = 3),
                                     valueBoxOutput("numZipsBox", width = 3)
                              )# end of column
                            ),# end of row
                            column(width = 12,
                              box(
                                title = "Best professions of 2016",
                                status = "success",
                                width = 12,
                                solidHeader = TRUE,
                                collapsible = TRUE,
                                fluidRow(
                                column(width = 3,
                                     box(
                                       title = "Best professions of 2016",
                                       width = 12,
                                       height = 530,
                                       background = "orange",
                                       h5("Before going somewhere lets first find what are earnings of the users based on their profession"),
                                       h5(
                                         paste("Seems like Software Development is having very high demand. Awesome ! I want to earn a lot of money.
                                               what technology I should in software development ? Okay.. Scroll down and know more")
                                       )
                                         )# end of box
                                       ),# end of column
                              column(width = 9,
                                     box(
                                       title = "Best Earning Profession",
                                       status = "success",
                                       width = 12,
                                       height = 530,
                                       plotlyOutput("top10tfidf")
                                     )
                              ) # End of column
                              )
                              )
                            ), 
                            
                            
                            
                            column(width = 12,
                                   box(
                                     title = "Let's talk about the technologies that are in high demand in 2016",
                                     status = "success",
                                     width = 12,
                                     solidHeader = TRUE,
                                     collapsible = TRUE,
                                     fluidRow(
                                       column(width = 3,
                                              box(
                                                title = "Let's talk about the technologies that are in high demand in 2016",
                                                width = 12,
                                                height = 530,
                                                background = "orange",
                                                solidHeader = FALSE,
                                                collapsible = FALSE,
                                                collapsed = FALSE,
                                                h5("It will help you to earn more.")
                                              )
                                              ),# end of column
                                       column(width = 9,
                                              box(
                                                title = "Trending Technology in 2016",
                                                status = "success",
                                                width = 12,
                                                height = 530,
                                                solidHeader = FALSE,
                                                collapsible = TRUE,
                                                plotlyOutput("trendingtech")
                                              ) #End of Box
                                       ) # End of column
                                       )
                            )
                          )
                          ) # End of fluidPage
                          ), # End of tabItem
                  tabItem(tabName = "compareall",
                          fluidPage(
                            title = "Compare all languages",
                            tags$head(
                              tags$script(src = 'http://d3js.org/d3.v3.min.js')
                            ),
                            
                            
                            column(width = 12,
                                   box(
                                     title = "Check common topics between different languages",
                                     status = "success",
                                     width = 12,
                                     solidHeader = TRUE,
                                     collapsible = TRUE,
                                     fluidRow(
                                       column(width = 3,
                                              box(
                                                title = "Lets explore all languages",
                                                width = 12,
                                                height = 700,
                                                background = "orange",
                                                solidHeader = FALSE,
                                                collapsed = FALSE,
                                                h5("Relations between different languages.")
                                              )# end of box
                                       ),# end of column
                                       column(width = 9,
                                              box(
                                                title = "Graphical Represention of top related word with Each Language",
                                                status = "success",
                                                width = 12,
                                                height = 700,
                                                solidHeader = FALSE,
                                                htmlOutput('networkPlot')
                                                #showOutput("top10StatesTS", "nvd3")
                                              ) 
                                       )#end of column
                                     )
                                   )
                            ),
                            
                            column(width = 12,
                                   box(
                                     title = "Similarity between two languages",
                                     status = "success",
                                     width = 12,
                                     solidHeader = TRUE,
                                     collapsible = TRUE,
                                     fluidRow(
                                       column(width = 3,
                                              box(
                                                title = "Lets check similarity between two languages",
                                                width = 12,
                                                height = 500,
                                                background = "orange",
                                                solidHeader = FALSE,
                                                collapsed = FALSE,
                                                h5("I hope it will help !")
                                              )# end of box
                                       ),
                                       column(width = 9,
                                              box(
                                                title = "Heat Map",
                                                status = "success",
                                                width = 12,
                                                height = 500,
                                                solidHeader = FALSE,
                                                plotlyOutput("heat")
                                              )
                                              
                                              
                                       )
                                     ),
                                     fluidRow(
                                       column(width = 3,
                                              box(
                                                title = "Related Terms",
                                                width = 12,
                                                height = 700,
                                                background = "orange",
                                                solidHeader = FALSE,
                                                collapsible = TRUE,
                                                
                                                h5("I hope it will help !")
                                              )# end of box
                                       ),
                                       column(width = 9,
                                              box(
                                                title = "Bubble Chart",
                                                status = "success",
                                                width = 12,
                                                height = 700,
                                                solidHeader = FALSE,
                                                collapsible = TRUE,
                                                bubblesOutput("bubble")
                                              )
                                       )
                                       
                                     )
                                   )
                            )
                            
                          )
                            
                  ),
                  
                  ### change the data sources 
                  tabItem(tabName = "comparetwo",
                          fluidPage(
                            title = "Language Explorer",
                            
                            column(width = 12,
                                   box(
                                     title = "Compare Two Languages",
                                     width = 12,
                                     status = "success",
                                     solidHeader = TRUE,
                                     background = "olive",
                                     uiOutput("Lang1Query4Ui"),
                                     uiOutput("Lang2Query4Ui"),
                                     actionButton("query1", label = "Go")
                                   ),
                                   
                                   conditionalPanel(
                                     condition = "input.query1",
                                     column(width = 12,
                                            box(
                                              title = "Data",
                                              status = "success",
                                              width = 12,
                                              solidHeader = TRUE,
                                              collapsible = TRUE,
                                              fluidRow(
                                                column(width = 3,
                                                       box(
                                                         title = "Significance of both language in different domains",
                                                         width = 12,
                                                         height = 530,
                                                         background = "orange",
                                                         solidHeader = FALSE,
                                                         collapsible = FALSE,
                                                         collapsed = FALSE,
                                                         h5("It will help you to pick a language !")
                                                       )# end of box
                                                ),
                                                column(width = 9,
                                                       
                                                       box(
                                                         title = paste("Significance of languages"),
                                                         status = "success",
                                                         width = 12,
                                                         height = 530,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         chartJSRadarOutput("radar")
                                                         
                                                       )
                                                )
                                              ),
                                              fluidRow(
                                                column(width = 3,
                                                       box(
                                                         title = "Popularity of both languages over time",
                                                         width = 12,
                                                         height = 530,
                                                         background = "orange",
                                                         solidHeader = FALSE,
                                                         collapsible = FALSE,
                                                         collapsed = FALSE,
                                                         h5("Pick the popular one ;) !")
                                                       )# end of box
                                                ),
                                                column(width = 9,
                                                       box(
                                                         title = paste("Language Popularity over years"),
                                                         status = "success",
                                                         width = 12,
                                                         height = 530,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         showOutput("winbyyear", "nvd3")
                                                         
                                                       )
                                                )
                                              ) ,
                                              
                                              fluidRow(
                                                column(width = 3,
                                                       box(
                                                         title = "How about connecting with experts near you ",
                                                         width = 12,
                                                         height = 530,
                                                         background = "orange",
                                                         solidHeader = FALSE,
                                                         collapsible = FALSE,
                                                         collapsed = FALSE,
                                                         h5("And land you dream job !")
                                                       )# end of box
                                                ),
                                                column(width = 9,
                                                       box(
                                                         title = paste("Find programmers around you !"),
                                                         status = "success",
                                                         width = 12,
                                                         height = 530,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         leafletOutput("map") 
                                                       )
                                                )
                                              )
                                              
                                            )
                                     )
                                     
                                   )
                            )
                          ) # End of fluidPage
                  )


          ) # end of tabITems
)# end of dashboard body
                 )# end of dashboard page