#'Create bar charts for speaker counts
#'
#'@param data dataset
#'@param ... vector containing strings
#'@export
#'@details
#'For multiple speakers, it is important to contain the names beteen "c()".
#'See examples for details.
#'@examples
#'plot_counts(data, "ROSE:")
#'plot_counts(data, c("Eleventh:", "CLARA:", "RIVER:"))
plot_counts<- function(data, ...) {
  person <- c(...)
  data %>%
    filter(speaker %in% person) %>%
    unnest_tokens(word, dialogue) %>%
    anti_join(stop_words) %>%
    group_by(speaker) %>%
    count(word, speaker, sort = TRUE) %>%
    top_n(10) %>%
    ungroup() %>%
    mutate(word = reorder(word, n)) %>%
    ggplot(aes(word, n, fill = speaker)) + ggplot2::geom_col(show.legend = FALSE) +
    ylab("Count") +
    xlab("Most Words")+
    scale_fill_brewer(palette = "Dark2") +
    coord_flip() +
    facet_wrap(~speaker, scales = "free") +
    theme_minimal()
}
