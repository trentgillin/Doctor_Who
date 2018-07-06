#' Edit data that has been scrapped from the web
#' @param 
#' @details 
#' It is important to have the doctor's name spelled the way you would like it presented within 
#' the data. Allows you to clean datasets pulled from the web so that each line is it's own row and
#' that the speaker and dialogue have their own column
#' @example
#' tidy_script(data, "Eleventh:)

tidy_script <- function(doctor_text, Doctor){

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
