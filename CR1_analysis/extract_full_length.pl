#! /usr/bin/perl -w
use strict; 
my $pad = 0;  

# extract fasta sequence that is between 2-4kb for L2 analysis
# extract fasta sequence that is between >2.5kb for CR1 analysis

my ($file) = @ARGV;
open(IN, $file) or die "can't open file $file:$!\n";
my $ch = '';
my $seq;
my $seq_name;
my %gs;
my $bin =0; 
my %hash;
my $head;
my $seq2;
my $head2;
my ($chr,$start,$end,$sym,$gid);
my $out3 = "full-length.".$file;
open(OUTC,">$out3");

$/=">";
while (<IN>){
    chomp;
    next if ($_ eq "");
    $_=~s/>//;
    next if ($_ eq "");
    my @tmp = split("\n",$_,2);
    $head = $tmp[0];
    $head =~s/\>//;
    $seq2 = $tmp[1];
    $seq2 =~s/\n//g;
    # L2 analysis, commented CR1 analysis below
    print OUTD "\>$_", if length($seq2) >=2000 && length($seq2) < 4000;
    # CR1 analysis, commented L2 analysis above
    print OUTD "\>$_", if length($seq2) >=2500;
}

close IN;
