##
## [loadandscrub.r]
##
## author     : Ed Goodwin
## project    : kexpedia
## createdate : 05.13.2016
##
## description: load and scrub data for Kaggle Expedia competition
## https://www.kaggle.com/c/expedia-hotel-recommendations
##
## Expedia is interested in predicting which hotel group a user is going to
## book. Expedia has in-house algorithms to form hotel clusters, where similar
## hotels for a search (based on historical price, customer star ratings,
## geographical locations relative to city center, etc) are grouped together.
## These hotel clusters serve as good identifiers to which types of hotels
## people are going to book, while avoiding outliers such as new hotels that
## don't have historical data.
##
## Your goal of this competition is to predict the booking outcome (hotel
## cluster) for a user event, based on their search and other attributes
## associated with that user event.
##
##
## version: 0.01 changelog:
##

require(data.table)
require(sqldf)

## URIs of data files...assumes you have a subdirectory called 'data' set up
## please do not add data files ot the GitHub
destf = "data/destinations.csv"
sampsubf = "data/sample_submission.csv"
testf = "data/test.csv"
trainf = "data/train.csv"

## set to false to read entire files
LOADSUBSET = TRUE

## read small subset of a datafile for decreasing load times and Proof of Concept (POC)
readsubsetfile = function(fname, nrows = 1000) {
  nlines = nrows
  subfile = fread(fname, header = TRUE, nrows = nlines)
  subfile
}

if(LOADSUBSET == TRUE) {
  trainsub = readsubsetfile(trainf, nrow=500)
  destsub = readsubsetfile(destf, nrow=500)
}

