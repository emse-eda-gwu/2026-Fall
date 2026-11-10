# Use these commands to install them if you have not already
# install.packages('plotly')
# install.packages('htmlwidgets')
# install.packages('htmltools')
# install.packages('reactable')
# install.packages('shiny')
# install.packages('rsconnect')

# Should be installed from previous classes:
library(knitr)
library(tidyverse)
library(fontawesome)
library(countdown)
library(metathis)
library(viridis)
library(cowplot)

# New
library(plotly)
library(reactable)

# Read in data sets for class
gapminder <- read_csv(file.path("data", "gapminder.csv"))
