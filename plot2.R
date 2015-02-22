# Preparing environment
## Set working directory
setwd('./Coursera/Exploratory_Data_Analysis')

## Download file if it doesn't already exist
data <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
local.data <- 'ExDA_project2.zip'

if (! file.exists(local.data)) {
        download.file(data,
                      destfile = local.data, method = 'curl')
}

## Unzip local data
if (file.exists(local.data)) {
        unzip(local.data)
}
## Remove downloaded archive
file.remove(local.data)

## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## Subset by Baltimore
baltimore <- NEI[NEI$fips=="24510",]
## Aggregate Baltimore's emissions
aggBaltimore <- aggregate(Emissions ~ year, baltimore,sum)
png("plot2.png")
barplot(
        aggBaltimore$Emissions,
        names.arg=aggBaltimore$year,
        xlab="Year",
        ylab="Emissions",
        main="Total Baltimore Emissions"
)
dev.off()