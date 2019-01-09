#' Edit data that has been scrapped from the web
#' 
#' @param doctor_text dataset
#' @param Doctor string variable for doctor
#' @export
#' @details 
#' It is important to have the doctor's name spelled the way you would like it presented within 
#' the data. Allows you to clean datasets pulled from the web so that each line is it's own row and
#' that the speaker and dialogue have their own column
#' @examples
#' tidy_script(eleventh, "Eleventh:")

tidy_script <- function(doctor_text, Doctor){
  
# Get episode numbers
episode_numbers <- as.character(1:length(doctor_text))

doctor_text <- mapply(cbind, doctor_text, "episode_number"= episode_numbers, SIMPLIFY=F, stringsAsFactors = FALSE)

doctor_text <- map_df(doctor_text, as.data.frame)

#Tidying the doctor text
doctor_tidy <- doctor_text %>%
  dplyr::filter(value != "") %>%
  distinct()

colnames(doctor_tidy) <- c("Text", "episode_number")

doctor_tidy$Text <- as.character(doctor_tidy$Text)

#Splitting the dataset into proper columns
doctor_dialogue <- doctor_tidy %>%
  mutate(speaker = ifelse(str_detect(Text, "[:upper:]+\\:"), 
                          str_extract(Text, "[:upper:]+\\:"), NA),
         speaker = ifelse(str_detect(speaker, "DOCTOR:"), 
                          Doctor, speaker),
         dialogue =ifelse(str_detect(Text, "[:upper:]+\\:"), 
                          str_extract(Text, "(?<=\\:).*(?=\\()|(?<=\\:).*(?=$)"), NA),
         stage_direction = ifelse(str_detect(Text, "\\[[:alpha:]+\\]|
                                             \\([:alpha:]+"), 
                                  str_extract(Text, "\\[[:alpha:]+\\]|
                                              (?<=\\().*(?=\\))"), NA))

return(doctor_dialogue)
}

