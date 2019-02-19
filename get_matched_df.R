library(dplyr)
library(tidyr)
library(tibble)

get_matched_df <- function(matchit_obj, orig_df) {
  # takes the output of `matchit()` and the original data_frame inputed in to `matchit()`
  # returns the original data frame with only the matched rows and a new column `pair`
  
  match_list <- matchit_obj$match.matrix %>% 
  as.data.frame() %>% 
  rownames_to_column() %>%
  select(rowname, control = 2) %>%
  filter(!is.na(control)) %>%
  mutate(pair = as.integer(as.character(rowname)), 
         rowname = as.integer(as.character(rowname)),
         control = as.integer(as.character(control)))

  match_list <- match_list %>% 
    select(rowname = control, pair) %>%
    bind_rows(match_list[c(1, 3)])

  matched_df <- orig_df 
  matched_df$rowname <- seq.int(nrow(matched_df))

  matched_df <- match_list %>%
    left_join(matched_df, by = "rowname")
  
  matched_df
}
