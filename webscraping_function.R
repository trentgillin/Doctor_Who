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
    
    print(text)
  }
  
  doctor_text <- map(doctor_links_added$value, get_text)
  
  print(doctor_text)
}
  
  
