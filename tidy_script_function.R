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
