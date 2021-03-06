% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/webscraping_function.R
\name{webscrape_lines}
\alias{webscrape_lines}
\title{Pull scripts from online}
\usage{
webscrape_lines(url)
}
\arguments{
\item{url}{chracter statmemt of url for doctor who scripts}
}
\description{
Pull scripts from online
}
\details{
This function allows you to get the doctor who lines from the website: wwww.chakoteya.net
As with any webscraping endeavor, it is important to ask permission before scraping someone's site.
}
\examples{
url <- "http://www.chakoteya.net/DoctorWho/episodes11.html"
webscrape_lines(url)
}
