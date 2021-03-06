% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting.R
\name{plot_survplot}
\alias{plot_survplot}
\title{plot_survplot}
\usage{
plot_survplot(fit, risktable, filename)
}
\arguments{
\item{fit}{A cox proportional hazards model. The output of the
function `fit_kaplan_estimator()` or `prognostic_classifier()`.}

\item{risktable}{A data.frame. The output of the function
`prognostic_classifier()`.}

\item{filename}{A character string. The filename.}
}
\description{
Helper function to create survival plot
}
