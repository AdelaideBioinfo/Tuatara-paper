# Tuatara transposon analysis
Contains the scripts used to analyse tuatara transposable elements, generate figures for the tuatara paper and infer phylogenies. 

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

#### Scripts

## Workflow

### 1) TE identification

#### 1a) CAPR was used to identify transposable elements in the tuatara genome, see ```CARP_pipeline.sh```

A more detailed pipeline can be found at: https://github.com/carp-te/carp-documentation

#### 1b) RepeatModeler was also used to identify transposable elements in the tuatara genome, details can be found at: http://www.repeatmasker.org/RepeatModeler/

### 2) Analysis of L2 elements in the tuatara genome

#### 2a) Classification of L2 elements in the tuatara genome

#### 2b) Phylogenetic analysis of tuatara L2 compared to other vertebrates

#### 2c) Phylogenetic analysis of tuatara L2 based on the RT domain

#### 2d) Kimura substituion level of tuatara L2 elements

### 3) Analysis of CR1 elements in the tuatara genome

#### 3a) Phylogenetic analysis of tuatara CR1 compared to other vertebrates

#### 3b) Analysis of tuatara CR1 based on th RT domain

#### 3c) Divergence rate of CR1 elements in the tuatara genome


### 4) Analysis of unclassified (un-annotated) consensus sequence in the tuatara genome

#### 4a) Haplotype analysis of unclassified repeats with only two members



