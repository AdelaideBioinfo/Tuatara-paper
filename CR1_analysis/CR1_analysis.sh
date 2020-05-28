#------------------------------------------#
#### 3a) CR1 phylogeny
#------------------------------------------#

# Extract full-length CR1 elements (>2.5kb)
perl extract_full_length.pl tua_V3.lib.fa.CR1
perl extract_full_length.pl rmk_tuaV3.fa.CR1

# Download vertebrates CR1 consensus sequences from Repbase
perl space_to_star.pl Repbase.CR1.fa > Repbase.CR1.fa.use
perl extract_full_length.pl Repbase.CR1.fa.use

# grep the title of full-length CR1 families
grep '>' full-length.$1.fasta.CR1 > title.full-length.$1.fasta.CR1
awk -F ':' '{print $1}' title.full-length.$1.fasta.CR1 > title.full-length.$1.fasta.CR1.use
sed 's/>//g' title.full-length.$1.fasta.CR1.use > title.full-length.$1.fasta.CR1.use2

# Extract their strand directions from CENSOR output
./grep_censor.sh title.full-length.$1.fasta.CR1.use2 > strand.full-length.$1.fasta.CR1

# Extract complement families and their corresponding consensus sequences
perl divide-+.pl strand.full-length.$1.fasta.CR1
perl extract_fasta_seq.pl strand.full-length.$1.fasta.CR1_comple full-length.$1.fasta.CR1 > comple.full-length.$1.fasta.CR1
perl extract_fasta_seq.pl strand.full-length.$1.fasta.CR1_forward full-length.$1.fasta.CR1 > forward.full-length.$1.fasta.CR1
 
# Reverse the complement sequences
perl reverse_complement.pl comple.full-length.$1.fasta.CR1 > reverse.full-length.$1.fasta.CR1

# rename consensus sequences, e.g.
sed -i 's/consensus/tuatara/g' forward.full-length.tuatara.fasta.CR1 > forward.full-length.tuatara.fasta.CR1
sed -i 's/consensus/tuatara/g' reverse.full-length.tuatara.fasta.CR1 > reverse.full-length.tuatara.fasta.CR1

# Merge all full-length CR1 consensus sequences
cat reverse.* forward.* full-length.rmk_tuaV3.fa.CR1 full-length.Repbase.CR1.fa.use > CR1_tree.fasta

# Run muscle alignment
muscle -in CR1_tree.fasta -out CR1_tree.afa -maxiters 2

# Use gblocks to remove the bad alignment
Gblocks CR1_tree.afa -t=d -p=n -e=.gb -b5=h
tr -d " \t" < CR1_tree.afa.gb > CR1_tree.afa.gbHalf.afa

# Build tree
fasttree -nt < CR1_tree.afa.gbHalf.afa > gblock_CR1_tree


#------------------------------------------#
#### 3b) Analysis of tuatara CR1 based on the RT domain
#------------------------------------------#

# merge all full-length CR1 from six species we generated from 
cat reverse.* forward.* > combined.full-length.CR1.fasta

# Identify ORF2p sequences (>500aa)
usearch -fastx_findorfs combined.full-length.CR1.fasta -ntout combined.full-length.CR1.fasta.out -aaout combined.full-length.CR1.fasta.translated -orfstyle 7 -mincodons 500

# Run muscle alignment
muscle -in combined.full-length.CR1.fasta.translated -out combined_CR1_RT_domain.afa -maxiters 2

# Use gblocks to remove the bad alignment
Gblocks combined_CR1_RT_domain.afa -t=d -p=n -e=.gb -b5=h
tr -d " \t" < combined_CR1_RT_domain.afa.gb > combined_CR1_RT_domain.afa.gbHalf.afa

# Build tree
fasttree -nt < combined_CR1_RT_domain.afa.gbHalf.afa > gblock_CR1_RT_domain_tree


#------------------------------------------#
#### 3c) CR1 divergence rate
#------------------------------------------#
# Calculate the divergence rate of different CR1 types in the tuatara genome
RepeatMasker -pa 32 -a -nolow -xsmall -gccalc -html -excln -dir ./ -lib tua_V3.lib.fa.CR1 tuatara_30Sep2015_rUdWx.fasta
perl ~/RepeatMasker/util/calcDivergenceFromAlign_test.pl -noCpG tuatara_30Sep2015_rUdWx.fasta.align > tuatara_30Sep2015_rUdWx.fasta.align.noCpG     
perl RM.addsize.div.pl tuatara_30Sep2015_rUdWx.fasta.align.noCpG > tuatara_30Sep2015_rUdWx.fasta.align.noCpG.size

# Remove the Unspecified string
sed 's/#Unspecified//g'  tuatara_30Sep2015_rUdWx.fasta.align.noCpG.size |awk '{print $5"\t"$6"\t"$7"\t"$8"\t"$10"\t"$11"\t"$17"\t"$15}' >  tuatara_30Sep2015_rUdWx.fasta.align.noCpG.size.use

# Format the data for plot
perl remove_secondstar.pl tuatara_11Aug2015_9ABnC.fa.align.noCpG.size.use > tmp
sed 's/CR1-1_CPB/tua_CR1_CPB-1#CR1_CPB/g; s/CR1-1B_CPB/tua_CR1_CPB-1B#CR1_CPB/g; s/CR1-5_CPB/tua_CR1_CPB-5#CR1_CPB/g; s/CR1-9_CPB/tua_CR1_CPB-9#CR1_CPB/g; s/CR1-10_CPB/tua_CR1_CPB-10#CR1_CPB/g; s/CR1-10B_CPB/tua_CR1_CPB-10B#CR1_C_CPB/g; s/CR1-12B_CPB/tua_CR1_CPB-12B#CR1_CPB/g; s/CR1-12_CPB/tua_CR1_CPB-12#CR1_CPB/g; s/CR1-15_AMi/tua_CR1_AMi-15#CR1_AMI/g; s/CR1-14_AMi/tua_CR1_AMi-14#CR1_AMI/g; s/CR1-15_Crp/tua_CR1_Crp-15#CR1_CRP/g; s/CR1-11_Crp/tua_CR1_Crp-11#CR1_CRP/g; s/CR1-8_Crp/tua_CR1_Crp-8#CR1_CRP/g; s/CR1_AC_1/tua_CR1_AC_1#CR1_AC/g' tmp > cr1.tuatara.use 
sed -i 's/kimura=//g' cr1.tuatara.use
sed -i '/PlatCR1/d; /L2/d; /L3/d' cr1.tuatara.use



