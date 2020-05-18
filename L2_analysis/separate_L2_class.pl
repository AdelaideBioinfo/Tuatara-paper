#!/usr/bin/perl -w
use strict;

# This script is to extract L2, CR1 and unclassified repeats
# or change the partial to \# 

my ($file)=@ARGV;
open(IN,"$file");
my $out1 = $file.".plat";
my $out2 = $file.".nonplat";

open(OUTA,">$out1");
open(OUTB,">$out2");
my (@single);

$/=">";
while(<IN>){
    chomp;   
    $_=~s/>//;
    next if ($_ eq "");
    @single = split("\n",$_,2);
    if ($single[0] =~ /(.*)L2_Plat/){
        print OUTA ">".$single[0]."\n".$single[1];
    }
    if ($single[0] !~ /(.*)L2_Plat/){
        print OUTB ">".$single[0]."\n".$single[1];
    }
}
