# Use CARP to identify transposable elements in the tuatara genome, all the Java code below can be found at: 
# https://github.com/carp-te/carp-documentation/tree/master/code

#### 1) Pairwise alignment between tautara genome sequences (krishna)
cd /yourpath/here/tuatara
matrix -threads=8 -krishnaflags="-tmp=/yourpath/here/temp -threads=2 -log -filtid=0.94 -filtlen=250" tuatara_30Sep2015_rUdWx.fasta

# Report repeat feature family groupings in JSON format
find ./ -maxdepth 1 -name '[!.]*.gff' -print0 | xargs -r0 cat > tua_krishna.gff
igor -in tua_krishna.gff -out tua_krishna.json

# Generate consensus sequence from genome intervals (seqer)
gffer <tua_krishna.json > tuatara_250bp_v3.igor.gff
seqer -aligner=muscle -dir=consensus -fasta=true -maxFam=100 -subsample=true -minLen=0.95 -threads=12 -ref=tuatara_30Sep2015_rUdWx.fasta tuatara_250bp_v3.igor.gff

# Annotate consensus sequences with repeat families downloade from Repbase and our own library
find ./consensus -maxdepth 1 -name '[!.]*.fq' -print0 | xargs -r0 cat > ConsensusSequences.fa
censor -bprm cpus=8 -lib ~/Vertebrates.fa -lib ~/our_known_reps_20130520.fasta ConsensusSequences.fa

#### 2) Classify consensus sequences
javac ClassifyConsensusSequences.java
java ClassifyConsensusSequences 

# Filter sequences by using WU-BLAST
# Identify potential protein sequences
xdformat -p -k uniprot_sprot.fasta
	
blastx ./report_run/sprot notKnown.fa  -gspmax=1 -E 0.00001 -B 1 -V 1 -cpus=32 > notKnown.fa.spwb
	
python ./report_run/wublastx2gff.py notKnown.fa.spwb > notKnown.fa.spwb.gff

# Identify GB_TE sequences 
xdformat -p -k GB_TE.21032016.fa -o GB_TE.new
	
blastx ./BlastDB/GB_TE.new notKnown.fa -gspmax=1 -E 0.00001 -B 1 -V 1 -cpus=32 > notKnown.fa.tewb
	
python ./report_run/wublastx2gff.py notKnown.fa.tewb > notKnown.fa.tewb.gff

# Identify potential retrovirus sequences
xdformat -n -k all_retrovirus.fasta
	
tblastx ./BlastDB/all_retrovirus.fasta notKnown.fa -gspmax=1 -E 0.00001 -B 1 -V 1 -cpus=32 > notKnown.fa.ervwb
	
python ./report_run/wublastx2gff.py notKnown.fa.ervwb > notKnown.fa.ervwb.gff

# Get protein information from consensus sequences
javac GetProteins.java
java GetProteins

# Check for simple sequence repeats
phobos-linux-gcc4.1.2 -r 7 --outputFormat 0 --printRepeatSeqMode 0 notKnownNotProtein.fa > notKnownNotProtein.phobos
javac IdentifySSRs.java
java IdentifySSRs

# Generate annotated repeat library, output library: tua_V3Library.fasta
javac GenerateAnnotatedLibrary.java
java GenerateAnnotatedLibrary

##### 3) Annotate tuatara genome with TE
# combine our tuatara library with LTR and SINE elements generated from collaborators
cat tua_V3Library.fasta Asuh_JGrau_repeat.fa > tua_V3.lib.fa
censor -bprm cpus=8 -lib ~/Vertebrates.fa -lib tua_V3.lib.fa tuatara_30Sep2015_rUdWx.fasta

#### 4) Calculate copy number, and percentage of each TE elements from CENSOR output
#!/bin/bash
for i in *.map;
do
    echo $i > test.txt
    wc -l $i > count.txt
    awk '{len+=$3-$2+1}{print len}' $i|tail -1 > test2.txt
    awk '{len+=$3-$2+1}{print (len/4272217537)*100}' $i|tail -1 > test3.txt
    paste test.txt count.txt test2.txt test3.txt >> repeat_constitution.txt
done

rm test*.txt
rm count.txt

#### 5) Extract L2/CR1/unclassified consensus sequences for the further analysis
perl classify_annotated_fasta.pl tua_V3.lib.fa
perl classify_annotated_fasta_rmd.pl rmk_tuaV3.fa





