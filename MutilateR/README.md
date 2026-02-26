# MutilateR

Mutation Induction Linking All The Exposures in R

A recurring question in the field of genetic toxicology has been, "how many mutations of a particular type would we expect to see, given a mutation frequency, mutational spectrum, and number of cells". This simulator attempts to answer that question and refine models for determining probabilites that a mutation X will occur given Y.

The fact that genetic toxicology assays are performed in existing cell populations (e.g., tissues, which can be in different stages of development, or have differing rates of cellular turnover and division; cell lines, in which variable numbers of cells may end up being sampled in the assay), where timing, mutation rates, and spectra can be highly variable, leads to difficulties in modeling this in a simple way.

The strategy for answering these questions comes in three phases:

## Build a mock population of cells

You can build a cell population (think of it as cells in a culture dish or cells in a tissue at whichever developmental stage you would like to model) using the `generate_population` function of this package. You might want to start with a single cell. You might want to start with a homgeneous population of 10^6 cells. Both scenarios are possible, though might create very different outcomes for the population of cells you are going to test.

You will want to consider the target DNA sequence at this point. You could simulate cell populations that have a genome consisting of 10 bp of DNA, or an entire genome of any composition. The only limit is your computational resources, time, and the FASTA file used to create mutations.

In R, we approach this scenario by creating nested list items. Each top-level list item represents a generation of cell division. Thus, each successive member of the list will have exponentially more cells than the previous generation. Within each generation, we then create a list item to track each cell. We need to understand how many cells are involved in the population to calculate various outcomes. But, if the mutation frequency is low enough (and the simulated genome small enough), you might end up with cells that have no mutations. In this case, we aren't going to bother considering or tracking the "no variant" events. We assume that users are only interested in mutations. So, the output for each simulated mutational event is tracked as rows of data that exist in a data frame for each cell. This is the most granular level of information to track, since it includes a start position, end position (1-based, to facilitate simple import into `GRanges` objects), chromosome (seqname), and whatever other metadata you like. This data frame also includes a column to uniquely identify the cell (`cell_id`), the generation within the population where the mutation occurred (`originating_generation`), and whether the mutation arose pre- or post-exposure (`mutation_timing`). With this data tracked, we can later combine bits and pieces of the lists with relative ease using table joins.


## Expose the population of cells to a mutagen

Now that, based on the above section, we have a population of cells sitting in our "lab", each of those cells will be placed into an "exposure vessel". We will then perform a second round of simulation on that seed data using the `expose_cells` function. This function will take your initial population and add more rounds of cell division. The number here will depend on your "exposure time", and consideration should be given to make this number similar to what a lab experiment might entail.  Keep in mind that for mutations to occur, they must be fixed by cell division. The dynamics of this could later be made more detailed by the inclusion of some kinetics for adduct formation, removal of DNA adducts by various types of repair machinery, etc., but for now we will simply consider the number of cell divisions during exposure, and the mutation frequency.

Since we are perhaps interested in different effect sizes, the `mut_freq`, or mutation frequency, will likely be different in some mock "samples". You might have "dose groups" where the frequency increases with increasing dose. You might also want to weight the spectrum in favor of different mutation subtypes in various "exposures". However, in most cases, you will want to comapre this to a mock "vehicle control" in which the same conditions used to create the cell population are continued (i.e., the same "background" mutation frequency and spectrum).


## Questions

Should I use the same 'seed' population in multiple experiments?

This is a good consideration; to reflect real life, of course, it makes more sense to create a new R object for each exposure. But, this might increase the time it takes to run the simulations. So it is a compromise that might need to be made.

## Statistics

We are careful to consider several probabilistic events:

1) The generation of mutations itself follows a quasi-Poisson distribution. This means... (expand on this)
2) Not all types of mutations are equally likely. To reflect this, we have taken advantage of the existing R package SynSigGen (https://github.com/steverozen/SynSigGen) to help generate mutational catalogs that reflect the processes at play.
