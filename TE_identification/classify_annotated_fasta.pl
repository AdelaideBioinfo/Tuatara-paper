#!/usr/bin/perl -w
use strict;

# This script is to extract L2, CR1 and unclassified repeats
# or change the partial to \# 

my ($file)=@ARGV;
open(IN,"$file");
my $out1 = $file.".L2";
my $out2 = $file.".CR1";
my $out3 = $file."_notsure";

open(OUTA,">$out1");
open(OUTB,">$out2");
open(OUTC,">$out3");
my (@single);

$/=">";
while(<IN>){
    chomp;   
    $_=~s/>//;
    next if ($_ eq "");
    @single = split("\n",$_,2);
    if ($single[0] =~ /(.*)consensus:L2/){
        print OUTA ">".$single[0]."\n".$single[1];
    }
    if ($single[0] =~ /(.*)consensus:(.*)CR1/ && $single[0] !~ /(.*)L2_Plat/ ){
        print OUTB ">".$single[0]."\n".$single[1];
    }
    if ($single[0] =~ /(.*)consensus#/){
        print OUTC ">".$single[0]."\n".$single[1];
    }
}
