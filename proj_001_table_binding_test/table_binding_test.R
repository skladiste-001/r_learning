library(dplyr)
library(magrittr)
library(stringr)
library(data.table)
library(crayon)

iteration_vector <- 1:10000

# tables to repeatedly insert
test_tibble_to_add <-
  tibble(col_a = c( 1 ,  4 ,  7 ,  9 ),
         col_b = c("a", "c", "b", "u"),
         col_c = c( 9 ,  5 ,  1 ,  8 ),
         col_d = c("z", "m", "j", "k"),
         col_e = c("m", "b", "u", "e"))

test_data_table_to_add <-
  data.table(col_a = c( 1 ,  4 ,  7 ,  9 ),
             col_b = c("a", "c", "b", "u"),
             col_c = c( 9 ,  5 ,  1 ,  8 ),
             col_d = c("z", "m", "j", "k"),
             col_e = c("m", "b", "u", "e"))

# initialization of test object
test_list <- list()
test_tibble <- test_tibble_to_add
test_data_table_01 <- test_data_table_to_add
test_data_table_02 <- test_data_table_to_add

# test adding to list
adding_to_list_start_time <- Sys.time()

for (index in iteration_vector) {
  
  test_list[[index]] <- test_tibble_to_add
}

adding_to_list_duration <- (Sys.time() - adding_to_list_start_time) %>% capture.output()

# test binding tibble
binding_tibble_start_time <- Sys.time()

for (index in iteration_vector) {
  
  test_tibble <- dplyr::bind_rows(test_tibble,
                                  test_tibble_to_add)
}

binding_tibbles_duration <- (Sys.time() - binding_tibble_start_time) %>% capture.output()

# test binding data table by dplyr::bind_rows
binding_data_table_start_time_test_01 <- Sys.time()

for (index in iteration_vector) {
  
  test_data_table_01 <- dplyr::bind_rows(test_data_table_01,
                                         test_data_table_to_add)
}

binding_data_table_with_dplyr_duration <- (Sys.time() - binding_data_table_start_time_test_01) %>% capture.output()

# test binding data table properly
binding_data_table_start_time_test_02 <- Sys.time()

for (index in iteration_vector) {
  
  test_data_table_02 <- data.table::rbindlist(list(test_data_table_02,
                                                   test_data_table_to_add))
}

binding_data_table_with_data_table_duration <- (Sys.time() - binding_data_table_start_time_test_02) %>% capture.output()

adding_to_list_duration %>%                     str_c("Adding items to list: ", .) %>%                green() %>% cat()
binding_tibbles_duration %>%                    str_c("Binding tibbles with dplyr: ", .) %>%          green() %>% cat()
binding_data_table_with_dplyr_duration %>%      str_c("Binding data tables with dplyr: ", .) %>%      green() %>% cat()
binding_data_table_with_data_table_duration %>% str_c("Binding data tables with data.table: ", .) %>% green() %>% cat()
