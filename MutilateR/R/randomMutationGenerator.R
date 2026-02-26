randomMutationGenerator <- function(numMutations=1000, groupName="Random") {
Group <- rep(groupName, numMutations)
Position <- sample(2:3096, numMutations, replace=T)
Ref <- vector()
Alt <- vector()

for(i in 1:length(Position)) {
	Ref <- c(Ref, substr(lacZ, Position[i], Position[i]))
	mutation <- sample(c("A", "C", "G", "T"), 1)
	while (mutation == Ref[i]) {
		mutation <- sample(c("A", "C", "G", "T"), 1)
	}
	Alt <- c(Alt, mutation)
}
return(data.frame(cbind(Group, Position, Ref, Alt)))
}


#' Get mutations from a sequence
#'
#' Used to generate a data frame with random mutations, including chr, start,
#' end, etc.
#'
#' @param seq The reference sequence to draw mutations from. Valid options are
#' hg38, mm10, or custom. If you specify custom, you must also provide a
#' reference file to load, using \code{"ref_file"}.
#' @param ref_file If you are using a custom genome, provide the path to
#' a FASTA file for the genome.
#' @param num_muts The number of mutations to draw.
#' @import GRanges
#' @import Biostrings
#' @export
get_random_muts <- function(seq = "test", ref_file = NULL, num_muts = 1) {
  if (seq == "custom") {
    stopifnot(!is.null(ref_file))
  } else { if (seq == "hg38") {
    # load hg38
  } else { if (seq == "mm10") {
  } else { if (seq == "test") {
    # Load in a test string...
    test_ref <- DNAString(x = "AGCTACTACTATCTATATTTCCGGCTACTATCTACT")
  }
  }
  }
  }

  muts <- data.frame()

  # Pick num_muts
  # Return data frame
  return(muts)
}

#' Generate a random position
#'
#' Helper function to generate a position within a set of chromosomes
#' @param chr A character vector of chromosome names
#' @param chr.sizes A numeric vector of chromosome sizes
#' @param width Width of the mutation. 1 is a single nucleotide variant.
#' @param sample_all_seqs T or F, if true, returns a mutation for each
#' chromosome/sequence name provided. If false, returns 1 mutated position.
#' @import GenomicRanges
#' @returns A GRanges object representing the random mutation position
#' @export
random_position <- function(chr, chr.sizes, width = 1, sample_all_seqs = F) {
  sample_size <- ifelse(sample_all_seqs == T, length(chr), 1)
  random_chr <- sample(x = chr, size = sample_size, prob = chr.sizes, replace = T)
  random_pos <- sapply(random_chr, function(chrTmp) { sample(chr.sizes[chr == chrTmp], 1) })
  res <- GRanges(random_chr,IRanges(random_pos,random_pos+width-1))
  return(res)
}

