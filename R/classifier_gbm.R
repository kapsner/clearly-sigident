#' @title gbm_classifier
#'
#' @description Helper function to create a gbm classifier model
#'
#' @param traininglist A list object containing the training data. The output
#'   of the function `create_training_test_split()`.
#' @param seed Intilization state of random number generator
#'
#' @inheritParams sigidentDiagnostic
#'
gbm_classifier <- function(
  traininglist,
  seed,
  nfolds,
  repeats,
  tunelength
) {

  stopifnot(
    unique(traininglist$train$y) %in% c(0, 1)
  )

  # initialize outlist
  outlist <- list()

  trn_ctrl <- caret::trainControl(
    method = "repeatedcv",
    number = nfolds,
    repeats = repeats,
    classProbs = TRUE
  )

  outlist$model <- build_predictive_gbm(
    train_x = traininglist$train$x,
    train_y = paste0("X", traininglist$train$y),
    trn_ctrl = trn_ctrl,
    tunelength = tunelength,
    seed = seed
  )

  outlist$prediction <- predict_caret(
    model = outlist$model,
    test_x = traininglist$test$x
  )
  outlist$confmat <- caret::confusionMatrix(
    data = factor(ifelse(as.numeric(
      as.character(outlist$prediction)
    ) < 0.5, 0, 1)),
    reference = traininglist$test$y,
    positive = "1"
  )
  outlist$roc <- calc_roc(
    test_y = traininglist$test$y,
    prediction = outlist$prediction
  )

  return(outlist)
}

#' @title build_predictive_gbm
#'
#' @description Function builds a gbm classifier model based on the given data.
#'
#' @param train_x The learning data values.
#' @param train_y The learning data classes.
#' @param trn_ctrl Options for the cross validation.
#'
#' @inheritParams sigidentDiagnostic
#'
build_predictive_gbm <- function(
  train_x,
  train_y,
  trn_ctrl,
  tunelength,
  seed
) {

  set.seed(seed)
  model <- caret::train(
    x = train_x,
    y = as.factor(train_y),
    method = "gbm",
    trControl = trn_ctrl,
    preProc = c("center", "scale"),
    tuneLength = tunelength,
    #allowParallel = T,
    verbose = FALSE
  )

  return(model)
}
