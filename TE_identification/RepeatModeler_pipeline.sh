# Use RepeatModeler to identify transposable elements in the tuatara genome

# Create a database for RepeatModeler
<RepeatModelerPath>/BuildDatabase -name tuatara tuatara_30Sep2015_rUdWx.fasta

# Run RepeatModeler
 nohup <RepeatModelerPath>/RepeatModeler -database tuatara -pa 20 >& run.out &