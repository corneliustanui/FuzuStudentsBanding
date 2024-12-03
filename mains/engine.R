# Project:     Fuzu Students Banding
# Author:      Cornelius Tanui (kiplimocornelius@gmail.com)
# Data source: Simulation
# Database:    N/A
# File name:   engine.R
# Purpose      App Engine Definition
# Date:        30 Nov 2024
# Version:     1

## load packages ----
library(tidyverse)  # data processing packages
library(tidymodels) # model definition packages
library(parsnip)    # model definition functions
library(glmnet)     # model processing engine
library(workflows)  # model definition functions

## load data ----
simulated_data <- readRDS(here::here("./data/simulated_data.rds"))

## create training and testing sets  ----
# set seed for reproducibility of the sets
set.seed(44)
data_split <- rsample::initial_split(simulated_data, prop = 0.75)

# 75% of records
train_data <- rsample::training(data_split) 

# 25% of records
test_data  <- rsample::testing(data_split)

## hyper-parameter tuning ----
# define model non-tuned model
multinom_reg_glmnet_spec_not_tuned <-
  parsnip::multinom_reg(penalty = tune(), mixture = tune()) |> # to be tuned
  parsnip::set_engine('glmnet') |>
  parsnip::set_mode("classification")

# define grid search
multinom_grid <- dials::grid_regular(dials::mixture(), dials::penalty(),
                                     levels = c(mixture = 3, penalty = 2))

# define 3-fold CV resamples from which to search best parameter values
multinom_3f_cv_folds <- rsample::vfold_cv(data = train_data, v = 3)

# create the recipe
multinom_recipe <- 
  
  # specify the outcome variable
  recipes::recipe(Bands ~ ., data = train_data) |>
  
  # coerce unknown or new levels not already in training data to NA
  recipes::step_unknown(GeographicalLocation) |>
  
  # specify predictors to be one-hot-encoded
  recipes::step_dummy(GeographicalLocation, Gender, Orphans, Disability) |>
  
  # center all normally distributed predictors
  recipes::step_center(GrossFamilyIncome, PovertyProbabilityIndex, 
                       NumberOfDependents, ProgramCostsKES) |>
  
  # scale all normally distributed predictors
  recipes::step_scale(GrossFamilyIncome, PovertyProbabilityIndex, 
                      NumberOfDependents, ProgramCostsKES) |>
  
  # normalize all numeric variables
  recipes::step_normalize(GrossFamilyIncome, PovertyProbabilityIndex, 
                          NumberOfDependents, ProgramCostsKES)

# define work flow
multinom_wf <- workflows::workflow() %>%
  workflows::add_recipe(multinom_recipe) |>
  workflows::add_model(multinom_reg_glmnet_spec_not_tuned)

# tune the hyperparameters using the grid search
multinom_tuned <- tune::tune_grid(
  multinom_wf,
  resamples = multinom_3f_cv_folds,
  grid = multinom_grid,
  control = tune::control_grid(save_pred = TRUE)
)

# select the best performing model
(best_parameter_values <- tune::select_best(multinom_tuned, metric = "accuracy"))

## define model tuned model ----
multinom_reg_glmnet_spec_tuned <-
  parsnip::multinom_reg(penalty = best_parameter_values$penalty, 
                        mixture = best_parameter_values$mixture) |>
  parsnip::set_engine('glmnet') |>
  parsnip::set_mode("classification")

# update workflow with tuned model
multinom_workflow <- 
  workflows::workflow() |>
  workflows::add_recipe(multinom_recipe) |>
  workflows::add_model(multinom_reg_glmnet_spec_tuned)

# train (fit) the model based on optimal parameters
multinom_fit <-
  multinom_workflow |>
  parsnip::fit(data = train_data)

## model performance diagnostics ----
# create new data (can be completely new or use training data without response variable)
predictors_data <- test_data |> dplyr::select(-Bands)

# use the model and the training data to get predictions of bands
bands_data <- test_data
bands_data$Bands_pred <- predict(multinom_fit, new_data = predictors_data, 
                                 type = "class")
bands_data$Bands_pred <- bands_data$Bands_pred$.pred_class

bands_data <- bands_data |> dplyr::select(Bands, Bands_pred)

## measure performance ----
# 1) confusion matrix
yardstick::conf_mat(data = bands_data, truth = Bands, estimate = Bands_pred)

# 2) kappa and accuracy
yardstick::metrics(data = bands_data, truth = Bands, estimate = Bands_pred)

# 3) precision (same as accuracy)
(prec <- yardstick::precision(data = bands_data, truth = Bands, 
                              estimate = Bands_pred, estimator = "micro"))

## save model object to disk ----
saveRDS(object = multinom_fit,
        file = "./mains/multinomial_regression_classifier.rds")

