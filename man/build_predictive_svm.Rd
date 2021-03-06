% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/classifier_svm.R
\name{build_predictive_svm}
\alias{build_predictive_svm}
\title{build_predictive_svm}
\usage{
build_predictive_svm(train_x, train_y, trn_ctrl, tunelength, seed = seed)
}
\arguments{
\item{train_x}{The learning data values.}

\item{train_y}{The learning data classes.}

\item{trn_ctrl}{Options for the cross validation.}

\item{tunelength}{An integer. The caret tuning length (default = 10).}

\item{seed}{A integer value. Seed to make machine learning algorithms
reproducible. Default: 111.}
}
\description{
Function builds a svm classifier model based on the given data.
}
