# Modeling hotel bookings in R using tidymodels and recipes
# https://www.youtube.com/watch?v=dbXDkEEuvCU


# libraries ---------------------------------------------------------------
library(tidyverse)
library(tidymodels)

# data --------------------------------------------------------------------

hotels <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-11/hotels.csv")

# explore data ------------------------------------------------------------

hotel_stays <- hotels %>%
  filter(is_canceled == 0) %>%
  mutate(
    children = case_when(
      children + babies > 0 ~ "children",
      TRUE ~ "none"
    ),
    required_car_parking_spaces = case_when(
      required_car_parking_spaces > 0 ~ "parking",
      TRUE ~ "none"
    )
  ) %>%
  select(-is_canceled, -reservation_status, -babies)


hotels_df <- hotel_stays %>%
  select(
    children, hotel, arrival_date_month, meal, adr, adults,
    required_car_parking_spaces, total_of_special_requests,
    stays_in_week_nights, stays_in_weekend_nights
  ) %>%
  mutate_if(is.character, factor)



# tidymodels --------------------------------------------------------------

library(tidymodels)
set.seed(1234)

hotel_split <- initial_split(hotels_df)

hotel_training <- training(hotel_split)
hotel_test <- testing(hotel_split)

hotel_rec <- recipe(children ~ ., hotel_training) %>% 
  step_downsample(children) %>% 
  step_dummy(all_nominal(), -all_outcomes()) %>% 
  step_zv(all_numeric()) %>% 
  step_normalize(all_numeric()) %>% 
  prep()

test_proc <- bake(hotel_rec, new_data = hotel_test)

knn_spec <- nearest_neighbor() %>% 
  set_engine("kknn") %>% 
  set_mode("classification")

knn_fit <- knn_spec %>% 
  fit(children ~ ., 
      data = juice(hotel_rec))

tree_spec <- decision_tree() %>% 
  set_engine("rpart") %>% 
  set_mode("classification")

tree_fit <- tree_spec %>% 
  fit(children ~ ., 
      data = juice(hotel_rec))


# evaluate model ----------------------------------------------------------

# validation set
set.seed(1234)
validation_splits <- mc_cv(juice(hotel_rec), prop = 0.9, strata = children)

knn_res <- fit_resamples(
  model = knn_spec, 
  children ~ ., 
  validation_splits, 
  control = control_resamples(save_pred = TRUE)
)
knn_res %>% 
  collect_metrics()


tree_res <- fit_resamples(
  model = tree_spec, 
  children ~ ., 
  validation_splits, 
  control = control_resamples(save_pred = TRUE)
)
tree_res %>% 
  collect_metrics()


# visualizations
knn_res %>% 
  unnest(.predictions) %>% 
  mutate(model = "kknn") %>% 
  bind_rows(tree_res %>% 
              unnest(.predictions) %>% 
              mutate(model = "rpart")) %>% 
  group_by(model) %>% 
  roc_curve(children, .pred_children) %>% 
  autoplot()


knn_res %>% 
  unnest(.predictions) %>% 
  conf_mat(children, .pred_class) %>% 
  autoplot(type = "heatmap")

knn_fit %>% 
  predict(new_data = test_proc, type = "prob") %>% 
  mutate(truth = hotel_test$children) %>% 
  roc_auc(truth, .pred_children)
