#' Generate a seed population of cells with mutations
#'
#' Create a digital "tissue", and return all the mutations
#' that have arisen within that "tissue". The purpose is to create a mock cell
#' population, over `n_div` rounds of cell division, starting with `n_start`
#' cells, using a mutation frequency, `mut_freq` and mutation process,
#' `mut_process`, across a reference DNA sequence, `ref`. At the end, you will
#' end up with a starting population of cells that "grew" using these specific
#' parameters. Then, this tissue can be mock "exposed" (or "expanded") to
#' simulate a cellular exposure to a mutagen (or control samples).
#'
#' @param n_div The number of cell divisions to simulate.
#' @param n_start The number of starting cells in the population.
#' @param ref Reference genome; hg38, mm10, or a path to a FASTA file
#' @param mut_freq The frequency of mutation to use in simulations.
#' @param mut_process The overall mutation spectrum to simulate, provided as...?
#' @import from ids random_id
#' @export
generate_population <- function(
  n_div = 3,
  n_start = 1,
  ref = "hg38",
  mut_freq = 0.1,
  mut_process = "" # matrix?
) {

  #### FOR TESTING PURPOSES - REMOVE FOR PRODUCTION
  #################################################
  n_div = 3
  n_start = 1
  ref = "hg38"
  mut_freq = 0.1
  #################################################


  message("
  Growing your cells. Please be patient - remember, in the lab this takes
  months, and often doesn't even work!
  ")
  # Make an empty data frame around which to structure simulations
  seed_table <- data.frame(
    chr = character(),
    start = numeric(),
    end = numeric(),
    cell = character(),
    originating_generation = numeric(),
    parental_cells = character(),
    mutation_timing = character()
  )
  # Make a list of cells the size of the starting generation...
  # This creates a list of empty data frames.
  # If you are starting with 1 cell (often true),
  # there will be a single element (empty data frame).
  seed_cells <- replicate(n = n_start, expr = seed_table, simplify = F)
  # These data frames will each recieve a name, in the form of a UUID
  names(seed_cells) <- lapply(seed_cells, uuid::UUIDgenerate)

  # Make a list where each element represents a generation...
  cells <- replicate(n = n_div, expr = list(), simplify = F)
  names(cells) <- paste0("Generation_",paste0(1:n_div))
  # For the first generation of cells, add in the seed population
  cells[[1]] <- seed_cells
  # Perform exponential doubling of seed population of cells...

  # Use Function: make_mutation
  # In the mean time, each row can be mocked up as such:
  make_mutation <- function() {
    return(c("chr1",10000,10000,"current_cell_ID"))

    # Once you get the number of mutations per sample, rbind the results of random_position() to a table, with as many rows as mutations selected
    # a <- random_position(chr = my_chr, chr.sizes = c(100,1000))
    # num_muts <- rnbinom(num_cells, mu = 4, size = 1)
  }

  # Where you need to get the name for
  mapply(function(x, i) paste(i, x), x, names(x))
  # Neg binomial distribution to get # mutations to include per cell:
    # Must be based on frequency
    # Frequency is used to calculate mean
    # How to best determine variability?

  # Lineage/Parental cells?
  cells <- lapply()
  return(cells)
}
