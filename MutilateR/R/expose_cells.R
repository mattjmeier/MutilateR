#' Expose a seed population of cells to a mutagen (or control)
#'
#' Simulates exposure of a cell population (provided as a dataframe which
#' should be created using the `generate_population` function). Your initial
#' cell population will expand over `n_div`, a given number of cell divisions,
#' using `mut_freq` and `mut_process` as the frequency of mutations and
#' spectrum to generate, respectively.
#'
#' @param population A data frame representing your initial cell popultion.
#' This object should be an output from `generate_population`.
#' @param n_div The number of cell divisions to simulate.
#' @param mut_freq The frequency of mutation to use in simulations.
#' @param mut_process The overall mutation spectrum to simulate, provided as...?
#' @export
expose_cells <- function(
  population = data.frame(),
  n_div = 3,
  mut_freq = 0.1,
  mut_process = ""
) {
  message("
  Exposing your cells. Please be patient - remember, in the lab this takes
  months... and also generates a lot of hazardous material to deal with!
  ")

}
