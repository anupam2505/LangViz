# LangViz
# Anupam Panwar check
# Date: September 29, 2016
#check

# global.R

###############################################################################
#                         LOAD PACKAGES AND MODULES                          #
###############################################################################
require(devtools)


require(rCharts)
options(RCHART_LIB = 'polycharts')
library(datasets)
library(dplyr)
library(ggplot2)
library(plotly)
library(plyr)
library(rCharts)
library(reshape)
library(shinydashboard)
library(TTR)
library(xlsx)
library(d3Network)
library(RCurl)
library(shiny)
library(bubbles)
library(dplyr)
library(stacksurveyr)
library(radarchart)
library(leaflet)
library(shinyjs)

################################################################################
#                             GLOBAL VARIABLES                                 #
################################################################################
#Default  Values
dflt <- list(state = "", county = "", city = "", zip = "", model = "ARIMA", 
                   split = as.integer(2014), maxValue = as.integer(1000000), stringsAsFactors = FALSE)

###############################################################################
#                               LOAD DATA                                     #
###############################################################################
#Delete the following line before deploying this to shiny.io
home <- getwd()

setwd("processedData")


languages     = read.csv("languages.csv", header = TRUE, stringsAsFactors = FALSE)
tfidf     = read.csv("question_keyphrases.csv", header = TRUE, stringsAsFactors = FALSE)
tfidf1     = read.csv("language_tags.csv", header = TRUE, stringsAsFactors = FALSE)
lang =  read.csv("language_time_series.csv", header = TRUE, stringsAsFactors = FALSE)
simmat <- read.csv("language_sim_matrix.csv", row.names=1)
sim <- as.matrix(simmat)
Language_keywords <- read.csv("Language_keywords.csv")
Language_keywords2 <- read.csv("language_common_topics.csv")

salary_by_occupation <- read.csv("salary_by_occupation.csv")
##radar
language_domain <- read.csv("language_domain.csv")
## Map
mapdata <- read.csv("aggregated_mapdata.csv")
nms <- names(sim.mat)
sim <- as.matrix(sim.mat)

# Read model data
modelData <- read.xlsx("models.xlsx", sheetIndex = 1, header = TRUE)

# File containing unique geo codes, state,city, zip
geo <- read.csv("geo.csv", header = TRUE)

#Set directory back to project home directory
setwd(home)