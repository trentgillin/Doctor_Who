count_sentiments <- function(data, ...){
  person <- c(...)
  
  data %>%
    filter(speaker %in% person) %>%
    unnest_tokens(word, dialogue) %>%
    anti_join(stop_words) %>%
    inner_join(get_sentiments("bing")) %>%
    group_by(speaker) %>%
    count(sentiment, sort = TRUE) %>%
    mutate(proportion = n / sum(n)) %>%
    ungroup() %>%
    ggplot(aes(sentiment, proportion, fill = speaker)) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~ speaker, scales = "free_y") +
    coord_flip()
}
