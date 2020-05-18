#!/usr/bin/perl 

my ($file)=@ARGV;
open(IN,"$file");
my $seq;
my $rvseq;

$/=">";
while(<IN>){
    chomp;
    $_=~s/>//;
    next if ($_ eq "");
    my @single = split("\n",$_,2);
    $seq = $single[1];
    #print $seq,"\n";
    $rvseq = revcomp($seq);
    print ">".$single[0].$rvseq."\n";
}

sub revcomp{
    my($DNAin) = @_;
    my $DNAout  = reverse($DNAin);
    $DNAout =~ tr/atcgATCG/tagcTAGC/;
    return $DNAout;
}