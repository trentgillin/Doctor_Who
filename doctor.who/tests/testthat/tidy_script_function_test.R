context("Data frame integrity")

eleventh_test <- webscrape_lines("http://www.chakoteya.net/DoctorWho/episodes11.html")

#Run tests
testthat::test_that("Is a data frame", {
  testthat::expect_that(doctor.who::tidy_script(eleventh_test, "Eleventh:"), testthat::is_a("data.frame"))
})
testthat::test_that("Has right number of columns", {
  testthat::expect_equal(ncol(doctor.who::tidy_script(eleventh_test, "Eleventh:")), 4)
})