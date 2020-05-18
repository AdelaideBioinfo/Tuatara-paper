#!/usr/bin/perl -w
use strict;

# Remove the string after second star in column 6

my ($file)=@ARGV;
open(IN,"$file");

while(<IN>){
    chomp;
    my @data = split("\t",$_);
    if($data[5] =~ /([\w\-\_\#]+)\*/){
        print "$data[0]\t$data[1]\t$data[2]\t$data[3]\t$data[4]\t$1\t$data[6]\t$data[7]\n";
    }
}