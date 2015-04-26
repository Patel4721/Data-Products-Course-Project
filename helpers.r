#' Aggregate dataset by state
#' 
#' @param dt data.table
#' @param year_min integer
#' @param year_max integer
#' @param evtypes character vector
#' @return data.table
#'
aggregate_by_state <- function(dt, evtypes) {
  replace_na <- function(x) ifelse(is.na(x), 0, x)
  round_2 <- function(x) round(x, 2)
  
  states <- data.table(nppes_provider_state=sort(unique(dt$nppes_provider_state)))
  
  aggregated <- dt %>% filter(provider_type %in% evtypes) %>%
    group_by(nppes_provider_state) %>%
    summarise_each(funs(sum), total_medicare_payment_amt)
  
  # We want all states to be present even if nothing happened
    left_join(states,  aggregated, by = "nppes_provider_state") %>%
    mutate_each(funs(replace_na), total_medicare_payment_amt) %>%
    mutate_each(funs(round_2), total_medicare_payment_amt)    
}

#' Add Spending column based on category
#'
#' @param dt data.table
#' @return data.table
#'
compute_affected <- function(dt) {
  dt %>% mutate(Spending = total_medicare_payment_amt)
}

#' Prepare map of medicare spending
#' 
#' @param dt data.table
#' @param states_map data.frame returned from map_data("state")
#' @param fill character name of the variable
#' @param title character
#' @param low character hex
#' @param high character hex
#' @return ggplot
#' 
plot_impact_by_state <- function (dt, states_map, fill, title, low = "#fff5eb", high = "#d94801") {
  p <- ggplot(dt, aes(map_id = nppes_provider_state))
  p <- p + geom_map(aes_string(fill = fill), map = states_map, colour='black')
  p <- p + expand_limits(x = states_map$long, y = states_map$lat)
  p <- p + coord_map() + theme_bw()
  p <- p + labs(x = "Long", y = "Lat", title = title)
  p + scale_fill_gradient(low = low, high = high)
}

#' Prepare dataset for downloads
#'
#' @param dt data.table
#' @return data.table
prepare_downloads <- function(dt) {
  dt %>% rename(
  State = nppes_provider_state, 
  Payment.Amount = total_medicare_payment_amt
  ) 
}