# Usage: RM.addsize.pl infile > outfile
# Will take in a RepeatMasker .out file and insert a new column that is the size of the hit in that row.

while(<>) {

        ($col1, $col2, $col3, $col4, $col5, $col6, $col7, $col8, $col9, $col10, $col11, $col12, $col13, $col14, $col15, $col16, $col17, $col18) = split;
        
        my $newcol = (($col7-$col6)+1);
        
        print "$col1\t$col2\t$col3\t$col4\t$col5\t$col6\t$col7\t$newcol\t$col8\t$col9\t$col10\t$col11\t$col12\t$col13\t$col14\t$col15\t$col16\t$col17\t$col18\n";
}
