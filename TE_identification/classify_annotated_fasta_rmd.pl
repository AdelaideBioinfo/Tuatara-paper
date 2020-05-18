#!/usr/bin/perl -w
use strict;

# This script is to extract L2, CR1 from RepeatModeler output
# or change the partial to \# 

my ($file)=@ARGV;
open(IN,"$file");
my $out1 = $file.".L2";
my $out2 = $file.".CR1";

open(OUTA,">$out1");
open(OUTB,">$out2");
my (@single);

$/=">";
while(<IN>){
    chomp;   
    $_=~s/>//;
    next if ($_ eq "");
    @single = split("\n",$_,2);
    if ($single[0] =~ /(.*)#LINE\/L2/){
        print OUTA ">".$single[0]."\n".$single[1];
    }
    if ($single[0] =~ /(.*)#LINE\/CR1/){
        print OUTB ">".$single[0]."\n".$single[1];
    }
}
