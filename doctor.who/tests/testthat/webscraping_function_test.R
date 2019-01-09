context("web data integrity")

#Pull in test dataset
doctor_links <- read_html("http://www.chakoteya.net/DoctorWho/episodes11.html", encoding = "ISO-8859-1") %>%
  html_nodes("table:nth-child(2) a") %>% 
  html_attr("href")

twelveth_links <- read_html("http://www.chakoteya.net/DoctorWho/episodes12.html", encoding = "ISO-8859-1") %>%
  html_nodes("table:nth-child(3) a") %>% 
  html_attr("href")


#Get the full link for each episode
doctor_links_added <- as.tibble(paste('http://www.chakoteya.net/DoctorWho',doctor_links, sep = "/"))
twelveth_links_added <- as.tibble(paste('http://www.chakoteya.net/DoctorWho',twelveth_links, sep = "/"))

#Actually pull text for each episode
get_text <- function(link) {
  text<- read_html(link, encoding = "ISO-8859-1") %>%
    html_nodes("td :nth-child(1)") %>%
    html_text() %>%
    as.tibble()
}

eleventh_test <- purrr::map(doctor_links_added$value, get_text)
twelveth_test <- purrr::map(twelveth_links_added$value, get_text)

#Run Test
testthat::test_that("scraped right table", {
  testthat::expect_equal(doctor.who::webscrape_lines("http://www.chakoteya.net/DoctorWho/episodes11.html"), eleventh_test)
  testthat::expect_equal(doctor.who::webscrape_lines("http://www.chakoteya.net/DoctorWho/episodes12.html"), twelveth_test)
})

testthat::test_that("Right output", {
  testthat::expect_that(doctor.who::webscrape_lines("http://www.chakoteya.net/DoctorWho/episodes12.html"), testthat::is_a('list'))
})