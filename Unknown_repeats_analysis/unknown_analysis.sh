# Analysis of unclassified repeats in the tuatara genome

#------------------------------------------#
#### 4a) Haplotype analysis of unclassified repeats with only two members
#------------------------------------------#
# Extract unclassified families with only two memebers 
grep '>' tua_V3.lib.fa_notsure > title_unknown
sed -i 's/>//g; s/_consensus.*//g' title_unknown
rsync --files-from=title_unknown consensus/mfa/ unknown_members > title_unknown
sed -i 's/>//g; s/_consensus.*//g' title_unknown
rsync --files-from=title_unknown consensus/mfa/ unknown_members/
grep '2 members' family* > 2member_unknown.txt
awk '!NF || !seen[$0]++' 2member_unknown.txt > title_unknown_2members.txt

rsync --files-from=title_unknown_2members consensus/mfa/ unknown_2members/

# BLASTN was used to check the sequence similarity between each unclassified families with only two members
./blastn.sh

# Calculate the percentage of unclassified repeats in the tuatara genome
# By using different alignment identity (99%, 99.5%, 99.9%, 100%)
# Rename CENSOR output of unclassified repeats 
sed 's/_consensus#Unclassified//g' tuatara_v3_masked_total.map > tuatara_v3_masked_total.rename
sed -i 's/_consensus#PartialAnnotation//g' tuatara_v3_masked_total.rename
sed -i 's/_consensus#Retrovirus_like//g' tuatara_v3_masked_total.rename
sed -i 's/_consensus#Chimeric//g' tuatara_v3_masked_total.rename

#------  >99% identity
awk '{if($3>=99)print}' total_alignment > haplotype_unknown.txt
awk '{print $1}' haplotype_unknown.txt > fam_haplotype_unknown.txt 
sed -i 's/_member0000//g' fam_haplotype_unknown.txt 
perl delete.same.pl fam_haplotype_unknown.txt tuatara_v3_masked_total.rename > tuatara_v3_masked_total.nohap
awk '{len+=$3-$2+1}{print (len/4272217537)*100}' tuatara_v3_masked_total.nohap |tail -1 
awk '{len=$3-$2+1}{print $1"\t"len}' tuatara_v3_masked_total.nohap > inter_tuatara_v3_masked_total.nohap
awk '{ a[$1]+=$2 }END{ for(i in a) print i,a[i] }' inter_tuatara_v3_masked_total.nohap > combined_tuatara_v3_masked_total.nohap
perl merge_same_contig.pl length_tuatara_contigV3 combined_tuatara_v3_masked_total.nohap > unknown_contig.txt

#------  >99.5% identity
awk '{if($3>=99.5)print}' total_alignment > haplotype_unknown2.txt
awk '{print $1}' haplotype_unknown2.txt > fam_haplotype_unknown2.txt 
sed -i 's/_member0000//g' fam_haplotype_unknown2.txt 
perl delete.same.pl fam_haplotype_unknown2.txt tuatara_v3_masked_total.rename > tuatara_v3_masked_total.nohap2
awk '{len+=$3-$2+1}{print (len/4272217537)*100}' tuatara_v3_masked_total.nohap2 |tail -1 
awk '{len=$3-$2+1}{print $1"\t"len}' tuatara_v3_masked_total.nohap2 > inter_tuatara_v3_masked_total.nohap2
awk '{ a[$1]+=$2 }END{ for(i in a) print i,a[i] }' inter_tuatara_v3_masked_total.nohap2 > combined_tuatara_v3_masked_total.nohap2
perl merge_same_contig.pl length_tuatara_contigV3 combined_tuatara_v3_masked_total.nohap2 > unknown_contig2.txt


#------  >99.9% identity
awk '{if($3>=99.9)print}' total_alignment > haplotype_unknown3.txt
awk '{print $1}' haplotype_unknown3.txt > fam_haplotype_unknown3.txt 
sed -i 's/_member0000//g' fam_haplotype_unknown3.txt 
perl delete.same.pl fam_haplotype_unknown3.txt tuatara_v3_masked_total.rename > tuatara_v3_masked_total.nohap3
awk '{len+=$3-$2+1}{print (len/4272217537)*100}' tuatara_v3_masked_total.nohap3 |tail -1 
awk '{len=$3-$2+1}{print $1"\t"len}' tuatara_v3_masked_total.nohap3 > inter_tuatara_v3_masked_total.nohap3
awk '{ a[$1]+=$2 }END{ for(i in a) print i,a[i] }' inter_tuatara_v3_masked_total.nohap3 > combined_tuatara_v3_masked_total.nohap3
perl merge_same_contig.pl length_tuatara_contigV3 combined_tuatara_v3_masked_total.nohap3 > unknown_contig3.txt


#------  100% identity
awk '{if($3>=100)print}' total_alignment > haplotype_unknown4.txt
awk '{print $1}' haplotype_unknown4.txt > fam_haplotype_unknown4.txt 
sed -i 's/_member0000//g' fam_haplotype_unknown4.txt 
perl delete.same.pl fam_haplotype_unknown4.txt tuatara_v3_masked_total.rename > tuatara_v3_masked_total.nohap4
awk '{len+=$3-$2+1}{print (len/4272217537)*100}' tuatara_v3_masked_total.nohap4 |tail -1 
awk '{len=$3-$2+1}{print $1"\t"len}' tuatara_v3_masked_total.nohap4 > inter_tuatara_v3_masked_total.nohap4
awk '{ a[$1]+=$2 }END{ for(i in a) print i,a[i] }' inter_tuatara_v3_masked_total.nohap4 > combined_tuatara_v3_masked_total.nohap4
perl merge_same_contig.pl length_tuatara_contigV3 combined_tuatara_v3_masked_total.nohap4 > unknown_contig4.txt
























