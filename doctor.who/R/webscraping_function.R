#'Pull scripts from online
#'
#'@param url chracter statmemt of url for doctor who scripts
#'@export
#'@details
#'This function allows you to get the doctor who lines from the website: wwww.chakoteya.net
#'As with any webscraping endeavor, it is important to ask permission before scraping someone's site.
#'@examples
#'url <- "http://www.chakoteya.net/DoctorWho/episodes11.html"
#'webscrape_lines(url)

webscrape_lines <- function(url){
  
  #Getting doctor's script links from online
  if (url != "http://www.chakoteya.net/DoctorWho/episodes12.html") {
    doctor_links <- read_html(url, encoding = "ISO-8859-1") %>%
      html_nodes("table:nth-child(2) a") %>% 
      html_attr("href")
  } else {
    doctor_links <- read_html(url, encoding = "ISO-8859-1") %>%
      html_nodes("table:nth-child(3) a") %>% 
      html_attr("href")
  }
  
  #Get the full link for each episode
  doctor_links_added <- as.tibble(paste('http://www.chakoteya.net/DoctorWho',doctor_links, sep = "/"))
  
  #Actually pull text for each episode
  get_text <- function(link) {
    text<- read_html(link, encoding = "ISO-8859-1") %>%
      html_nodes("td :nth-child(1)") %>%
      html_text() %>%
      as.tibble()
  }
  
  doctor_text <- map(doctor_links_added$value, get_text)
  
  return(doctor_text)
}
  
  
