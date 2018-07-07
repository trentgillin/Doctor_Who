#' Allows to graphically represent the positive and negative words a speaker says.
#' 
#' @param 
#' @export
#' @details 
#' Using the "bing" sentiment codes, allows you to count and graph the number of positive and negative words a 
#' speaker will say. 
#' @examples
#'count_sentiments(eleventh, "Eleventh:")

count_sentiments <- function(data, ...){
  person <- c(...)
  
  data %>%
    filter(speaker %in% person) %>%
    unnest_tokens(word, dialogue) %>%
    anti_join(stop_words) %>%
    inner_join(get_sentiments("bing")) %>%
    group_by(speaker) %>%
    count(sentiment, sort = TRUE) %>%
    mutate(Percent = (n / sum(n)*100)) %>%
    ungroup() %>%
    ggplot(aes(sentiment, Percent, fill = speaker)) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~ speaker, scales = "free_y") +
    coord_flip()
}
