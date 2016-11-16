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
library(forecast)
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

currentZip    = read.csv("currentZip.csv", header = TRUE, stringsAsFactors = FALSE)
currentCity   = read.csv("currentCity.csv", header = TRUE, stringsAsFactors = FALSE)
currentCounty = read.csv("currentCounty.csv", header = TRUE, stringsAsFactors = FALSE)
currentState  = read.csv("currentState.csv", header = TRUE, stringsAsFactors = FALSE)
hviAllZip     = read.csv("hviAllZip.csv", header = TRUE, stringsAsFactors = FALSE)
hviAllCity    = read.csv("hviAllCity.csv", header = TRUE, stringsAsFactors = FALSE)
hviAllCounty  = read.csv("hviAllCounty.csv", header = TRUE, stringsAsFactors = FALSE)
hviAllState   = read.csv("hviAllState.csv", header = TRUE, stringsAsFactors = FALSE)
languages     = read.csv("languages.csv", header = TRUE, stringsAsFactors = FALSE)
tfidf     = read.csv("question_keyphrases.csv", header = TRUE, stringsAsFactors = FALSE)
lang =  read.csv("language_time_series.csv", header = TRUE, stringsAsFactors = FALSE)

# Read model data
modelData <- read.xlsx("models.xlsx", sheetIndex = 1, header = TRUE)

# File containing unique geo codes, state,city, zip
geo <- read.csv("geo.csv", header = TRUE)

#Set directory back to project home directory
setwd(home)