# Tuatara transposon analysis
Contains the scripts used to analyse LINEs and unknown repeats in the tuatara genome, generate figures for the tuatara paper and infer phylogenies. 

#### Used programs
- CARP (https://github.com/carp-te/carp-documentation)
- RepeatModeler (http://www.repeatmasker.org/RepeatModeler/)
- CENSOR, which requires wu-blast and bioperl (https://girinst.org/downloads/software/censor/)
- BLAST (https://blast.ncbi.nlm.nih.gov/Blast.cgi)
- Repbase https://www.girinst.org/server/RepBase/
- MUSCLE (https://www.drive5.com/muscle/)
- USEARCH (https://www.drive5.com/usearch/)
- RepeatMasker (http://www.repeatmasker.org/)
- HMMer (http://hmmer.org/)
- FastTree (http://www.microbesonline.org/fasttree/)
- MrBayes (https://nbisweden.github.io/MrBayes/download.html)
- PILER (https://www.drive5.com/piler/)

## Workflow

### 1) TE identification

1a) CAPR was used to identify transposable elements in the tuatara genome 

See [CARP_pipeline.sh](TE_identification/CARP_pipeline.sh)

The tuatara draft genome assembly (~5 Gbp) was used for repeat identification. All tuatara genome scaffolds were pairwise aligned using Krishna with parameters set for 94% sequence identity and a minimum length of 250bp. 

A more detailed pipeline is described at: https://github.com/carp-te/carp-documentation

This step provides us an annotation of repeats in the tuatara genome from CARP.

1b) RepeatModeler (RMD) was also used to identify transposable elements in the tuatara genome 

See [RepeatModeler_pipeline.sh](TE_identification/RepeatModeler_pipeline.sh)

A more detailed pipeline can be found at: http://www.repeatmasker.org/RepeatModeler/.

We then combined these two repeats libraries with manually generated SINE and LTR elements from Alex and Jose. CENSOR was used to map these sequences back to the tuatara genome, which we found around 64% of the tuatara genome was annotated as repetitive. 

### 2) Analysis of L2 elements in the tuatara genome 

See [L2_analysis.sh](L2_analysis/L2_analysis.sh)

#### 2a) Classification of L2 elements in the tuatara genome

In order to investigate the similarity of tuatara L2 generated from CARP and RMD, we extracted long L2 (2-4kb) consensus sequences from both libraries. MUSCLE was used to carry out global alignments between the two repeat sequence sets. FastTree was used to infer a maximum likelihood phylogeny from the alignment output. FigTree was used to visualise and annotate the tree using repeat class labels.

#### 2b) Phylogenetic analysis of tuatara L2 compared to other vertebrates

In order to determine the evolutionary position of tuatara L2 within vertebrates, L2 consensus sequences between 2-4kb long identified from CARP and RMD were extracted, L2 consensus sequences (2-4kb) were also extracted from the Repbase 'Vertebrates' library. 222 L2 consensus sequences were globally aligned by using MUSCLE. FastTree was used to infer a maximum likelihood phylogeny from the alignment output. Archaeopteryx beta was used to visualise and annotate the trees using repeat class labels.

#### 2c) Phylogenetic analysis of tuatara L2 based on the RT domain

These long L2 consensus sequences, and anole, turtle and crocodile L2 consensus sequences were extracted from the Repbase library. USEARCH was then used to scan for open reading frames in L2 consensus sequences that were at least 60% of the expected length (>1.5kb for ORF2p). After translation, ORF2p candidates were checked for similarity to known domains using HMM-HMM comparison against the Pfam28.0 database. ORF2p containing RT domains were extracted using the envelope coordinates from the HMMer domain hits table (–domtblout), with a minimum length of 200 amino acids. Nucleotide sequences that contained RT domains were extracted and assembled into one file. 

Two methods were tested to describe the evolutionary dynamics of potentially active L2 elements: 

1) FastTree was used to infer a maximum likelihood phylogeny (-nt, -gtr);

2) MrBayes was used to infer a Bayesian inference phylogeny (lse nst=6; mcmc ngen=30000 samplefreq=200 printfreq=200 diagnfreq=1000).

#### 2d) Possible horizontal transfer between tuatara and platypus

CENSOR was used with a custom library of platypus-like and non-platypus-like L2 consensus sequences from tuatara to find similar sequences (both full length and fragments) in five reptile genomes (anole, crocodile, alligator and bearded dragon) and one monotreme genome (platypus). To confirm the validity of hits, each hit was extracted as a nucleotide sequence and aligned with BLASTN (default parameter) against the platypus-like tuatara L2 and non-platypus like tuatara L2 consensus sequences. Hits smaller than 50 bp were discarded.

#### 2e) Kimura substitution level of tuatara L2 elements

MUSCLE and PILER were used to build two super consensus sequences, one was generated from platypus-like tuatara L2, the other one was generated from non-platypus like tuatara L2. RepeatMasker was used to align each super consensus against their corresponding tuatara L2 elements, in order to calculate divergence rate using Kimura 2-parameter divergence metric, adjusted for ‘GC’ content.

### 3) Analysis of CR1 elements in the tuatara genome 

See [CR1_analysis.sh](CR1_analysis/CR1_analysis.sh)

#### 3a) Phylogenetic analysis of tuatara CR1 compared to other vertebrates

In order to determine the evolutionary position of tuatara CR1 within vertebrates, CR1 consensus sequences between 2.5-4kb long identified from CARP and RMD were extracted, CR1 consensus sequences (2.5-4kb) were also extracted from the Repbase 'Vertebrates' library. 231 CR1 consensus sequences were globally aligned by using MUSCLE. FastTree was used to infer a maximum likelihood phylogeny from the alignment output. Archaeopteryx beta was used to visualise and annotate the trees using repeat class labels.

#### 3b) Potential active CR1 elements in the tuatara genome

USEARCH was used to scan long CR1 consensus sequences for open reading frames that were at least 60% of the expected length (>1.5kb for ORF2p). After translation, ORF2p candidates were checked for similarity to known domains using HMM-HMM comparison against the Pfam28.0 database. ORF2p containing RT domains were extracted using the envelope coordinates from the HMMer domain hits table (–domtblout), with a minimum length of 200 amino acids. Nucleotide sequences that contained RT domains were extracted and assembled into one file.

#### 3c) Divergence rate of CR1 elements in the tuatara genome

In order to plot the relative age profiles of CR1 insertions, tuatara CR1 consensus sequences identified using CARP were aligned and annotated against the tuatara genome by using RepeatMasker version open-4.0 (-pa 32 -a -nolow -xsmall -gccalc -html -excln). Kimura distances were calculated using RepeatLandscape from the RepeatMasker alignment out files (-noCpG). Kimura distances are computed based on the rates of transitions and transversions between the tuatara genomic sequences and the CR1 consensus sequence, allowing estimation of the relative ages of inserted CR1 copies.

### 4) Analysis of unclassified (un-annotated) consensus sequence in the tuatara genome 

See [unknown_analysis.sh](Unknown_repeats_analysis/unknown_analysis.sh)

#### 4a) Haplotype analysis of unclassified repeats with only two members

In order to check whether assembly issues such as alternative haplotypes may partially explain segmental duplications identified from CARP, we have tested this by looking at the 99%, 99.5%, 99.9% and 100% identity for the alignments of these sequence pairs. 


