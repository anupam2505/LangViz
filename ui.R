# shinyHome
# Real Estate Analytics and Forecasting
# John James
# Date: June 27, 2016

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
                                     menuSubItem("Campare All", icon = icon("user"),tabName = "compareall"),
                                     menuSubItem("Caompare Two", icon = icon("coffee"),tabName = "comparetwo")
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
                                     valueBoxOutput("numStatesBox", width = 3),
                                     valueBoxOutput("numCountiesBox", width = 3),
                                     valueBoxOutput("numCitiesBox", width = 3),
                                     valueBoxOutput("numZipsBox", width = 3)
                              )# end of column
                            ),# end of row
                            fluidRow(
                              column(width = 3,
                                     box(
                                       title = "Welcome to Language Analytics",
                                       width = 12,
                                       height = 530,
                                       background = "orange",
                                       solidHeader = FALSE,
                                       collapsible = FALSE,
                                       collapsed = FALSE,
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
                                       status = "primary",
                                       width = 12,
                                       height = 530,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       plotlyOutput("top10tfidf")
                                     )
                              ) # End of column
                            ), 
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
                                     )# end of box
                              ),# end of column
                              column(width = 9,
                                     box(
                                       title = "Trending Technology in 2016",
                                       status = "primary",
                                       width = 12,
                                       height = 530,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       plotlyOutput("trendingtech")
                                     ) #End of Box
                              ) # End of column
                            )
                            # end of fluidrow
                          ) # End of fluidPage
                          ), # End of tabItem
                  tabItem(tabName = "compareall",
                          fluidPage(
                            title = "Compare all languages",
                            tags$head(
                              tags$script(src = 'http://d3js.org/d3.v3.min.js')
                            ),
                            fluidRow(
                              column(width = 12,
                                     box(
                                       title = "Graphical Represention of top related word with Each Language",
                                       status = "primary",
                                       width = 12,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       htmlOutput('networkPlot')
                                       #showOutput("top10StatesTS", "nvd3")
                                     ) 
                              )#end of column
                            ),
                            
                            fluidRow(
                              column(width = 12,
                                     box(
                                       title = "Heat Map",
                                       status = "primary",
                                       width = 12,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       plotlyOutput("heat")
                                       )
                                       
                                       
                                     )
                              ),
                            fluidRow(  
                            column(width = 12,
                                     box(
                                       title = "Bubble Chart",
                                       status = "primary",
                                       width = 12,
                                       solidHeader = FALSE,
                                       collapsible = TRUE,
                                       bubblesOutput("bubble")
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
                                     status = "primary",
                                     solidHeader = TRUE,
                                     background = "navy",
                                     uiOutput("Lang1Query4Ui"),
                                     uiOutput("Lang2Query4Ui"),
                                     actionButton("query1", label = "Go")
                                   ),
                                   
                                   conditionalPanel(
                                     condition = "input.query1",
                                     column(width = 12,
                                            box(
                                              title = "Data",
                                              status = "primary",
                                              width = 12,
                                              solidHeader = TRUE,
                                              collapsible = TRUE,
                                              fluidRow(
                                                column(width = 12,
                                                       box(
                                                         title = paste("Find programmers around you !"),
                                                         status = "primary",
                                                         width = 12,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         leafletOutput("map") 
                                                       )
                                                )
                                              )
                                              ,
                                              fluidRow(
                                                column(width = 12,
                                                       box(
                                                         title = paste("Language Posts over years"),
                                                         status = "primary",
                                                         width = 12,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         showOutput("winbyyear", "nvd3")
                                                         
                                                       )
                                                )
                                              ) ,
                                              fluidRow(
                                                column(width = 12,
                                                       
                                                       box(
                                                         title = paste("Significance of language"),
                                                         status = "primary",
                                                         width = 12,
                                                         solidHeader = FALSE,
                                                         collapsible = TRUE,
                                                         chartJSRadarOutput("radar")
                                                         
                                                       )
                                                )
                                              ) 
                                              
                                            )
                                     )
                                     
                                   )
                            )
                          ) # End of fluidPage
                  ),
                  
                  
                  
                  tabItem(tabName = "explorer",
                          fluidPage(
                            title = "Explorer",
                            column(width = 2,
                                   box(
                                     title = "Query Builder",
                                     status = "primary",
                                     width = 12,
                                     solidHeader = TRUE,
                                     background = "navy",
                                     box(
                                       width = 12,
                                       status = "primary",
                                       solidHeader = FALSE,
                                       background = "navy",
                                       uiOutput("levelQueryUi")
                                     ),# end of box
                                     conditionalPanel(
                                       condition = "input.analysisLevel == 2",
                                       box(
                                         status = "primary",
                                         solidHeader = FALSE,
                                         width = 12,
                                         background = "navy",
                                         uiOutput("stateQuery2Ui")
                                       )# end of box
                                     ),# end of conditional panel  
                                     conditionalPanel(
                                       condition = "input.analysisLevel == 3",
                                       box(
                                         status = "primary",
                                         solidHeader = FALSE,
                                         width = 12,
                                         background = "navy",
                                         uiOutput("stateQuery3Ui"),
                                         uiOutput("countyQuery3Ui")
                                       )# end of box
                                     ),# end of conditionalpanel    
                                     conditionalPanel(
                                       condition = "input.analysisLevel == 4",
                                       box(
                                         status = "primary",
                                         solidHeader = FALSE,
                                         width = 12,
                                         background = "navy",
                                         uiOutput("stateQuery4Ui"),
                                         uiOutput("countyQuery4Ui"),
                                         uiOutput("cityQuery4Ui")
                                       )# end of box
                                     ),# end of conditionalpanel
                                     box(
                                       status = "primary",
                                       solidHeader = FALSE,
                                       width = 12,
                                       background = "navy",
                                       sliderInput("hviQuery", label = "Home Value Range ($000)", min = 0, max = 2000, value = c(0,1000)),
                                       checkboxInput("maxValue", label = "Include all values exceeding $2m", value = FALSE)
                                     ), # end of box
                                     box(
                                       status = "primary",
                                       solidHeader = FALSE,
                                       width = 12,
                                       background = "navy",
                                       selectInput("horizon", label = "Time Horizon:", 
                                                   choices = c("Monthly", "Quarterly", "Annual", "5 Year", "10 Year"),
                                                   selected = "Annual",
                                                   selectize = FALSE),
                                       numericInput("minGrowth", label = "Minimum Growth Rate (%)", value = 1)
                                     ),# end of box
                                     actionButton("query", label = "Go") 
                                   )# end of box
                            ),# end of column
                            conditionalPanel(
                              condition = "input.query",
                              column(width = 10,
                                     box(
                                       title = "Market Data",
                                       status = "primary",
                                       width = 12,
                                       solidHeader = TRUE,
                                       collapsible = TRUE,
                                       fluidRow(
                                         box(
                                           title = "Value Growth by Value Scatterplot",
                                           status = "primary",
                                           width = 12,
                                           solidHeader = FALSE,
                                           collapsible = TRUE,
                                           plotlyOutput("valueByGrowth")
                                         )# end of box
                                       ),# end of fluidrow
                                       fluidRow(
                                         column(width = 12,
                                                box(
                                                  title = "Distribution of Median Home Values",
                                                  status = "primary",
                                                  width = 6,
                                                  solidHeader = FALSE,
                                                  collapsible = TRUE,
                                                  plotOutput("valueHist")
                                                ),# end of box
                                                box(
                                                  title = "Markets Table",
                                                  status = "primary",
                                                  width = 6,
                                                  solidHeader = FALSE,
                                                  collapsible = TRUE,
                                                  dataTableOutput("marketTbl")
                                                )# end of box
                                         ),# end of column
                                         column(width = 12,
                                                box(
                                                  title = "Top Markets by Growth",
                                                  status = "primary",
                                                  width = 12,
                                                  height = 400,
                                                  solidHeader = FALSE,
                                                  collapsible = TRUE,
                                                  showOutput("topByGrowth", "nvd3")
                                                )# end of box
                                         )# end of column
                                       ),# end of fluidRow
                                       fluidRow(
                                         box(
                                           title = "Median Home Value Time Series for Top Growth Markets",
                                           status = "primary",
                                           width = 12,
                                           height = 700,
                                           solidHeader = FALSE,
                                           collapsible = TRUE,
                                           showOutput("topMarketsTS", "nvd3")
                                         ) #End of Box
                                       )# end of fluidrow
                                     )# end of box
                              )#end of column
                            ) # end of conditionalpanel
                          ) # End of fluidPage
                  ), # End of tabItem 
                                 
                  
                  
                  
tabItem(tabName = "helpDashboard",
        column(width = 4,
               box(
                 width = 12,
                 background = "green",
                 solidHeader = FALSE,
                 collapsible = FALSE,
                 collapsed = FALSE,
                 h3("Dashboard"),
                 p(
                   paste("The Dashboard provides an introduction to the site and some basic 
                         statistics on the US housing market such as:")),
                 tags$ol(
                   tags$li("US Home Value Index – Median Home Price [1]"),
                   tags$li("Market with highest median home value [2]"),
                   tags$li("The US annual growth in median home values [3]"),
                   tags$li("Market with highest annual growth in home values [4]"),
                   tags$li("The top 10 states by median home value growth [5]"),
                   tags$li("The top 10 cities by median home value growth [6]"),
                   tags$li("Top 10 states by median home value growth home value price time series [7]"),
                   tags$li("Top 10 cities by median home value growth home value time series [8]")
                 ),# end of tags$ol
                 p(
                   paste("The data set for this site includes current and historical home value 
                         indices for over 20,000 markets.  The Market Explorer page will allow you to query 
                         and report on markets from the state to the zip code level."))
                   )# end of box
                   ),# end of column
        column(width = 8,
               box(
                 status = "primary",
                 width = 12,
                 solidHeader = FALSE,
                 img(src = "dashboard1.png", height = 400, width = 1020),
                 img(src = "dashboard2.png", height = 300, width = 1020)
               )# end of box
        )# end of column
                   ) #end of tabItem


          ) # end of tabITems
)# end of dashboard body
                 )# end of dashboard page