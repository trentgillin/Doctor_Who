webscrape_lines <- function(url, Doctor){

#Getting doctor's script links from online
if (Doctor != "Twelveth:") {
doctor_links <- read_html(url) %>%
  html_nodes("table:nth-child(2) a") %>% 
  html_attr("href")
} else {
  doctor_links <- read_html(url) %>%
    html_nodes("table:nth-child(3) a") %>% 
    html_attr("href")
}

#Get the full link for each episode
doctor_links_added <- as.tibble(paste('http://www.chakoteya.net/DoctorWho',doctor_links, sep = "/"))

#Actually pull text for each episode
get_text <- function(link) {
  text<- read_html(link) %>%
    html_nodes("td :nth-child(1)") %>%
    html_text() %>%
    as.tibble()
  
  print(text)
}

doctor_text <- map(doctor_links_added$value, get_text)

#Tidying the doctor text
doctor_tidy <- doctor_text %>%
  unlist()%>%
  as.data.frame()%>%
  filter(.!="")%>%
  unique()

colnames(doctor_tidy) <- "Text"

doctor_tidy$Text <- as.character(doctor_tidy$Text)

#Splitting the dataset into proper columns
doctor_tidy%<>%
  mutate(diaglogue = str_split(Text, "\\W(?=[:upper:][:upper:])"))

doctor_dialogue <- unique(as.tibble(unlist(doctor_tidy$diaglogue)))

doctor_dialogue$value <- str_replace_all(doctor_dialogue$value, "[\r\n]" , " ")

doctor_dialogue%<>%
  mutate(speaker = ifelse(str_detect(value, "[:upper:]+\\:"), 
                          str_extract(value, "[:upper:]+\\:"), ""),
         speaker = ifelse(str_detect(speaker, "DOCTOR:"), 
                          Doctor, speaker),
         dialogue =ifelse(str_detect(value, "[:upper:]+\\:"), 
                          str_extract(value, "(?<=\\:).*(?=\\()|(?<=\\:).*(?=$)"),""))

return(doctor_dialogue)
}

