#!/usr/bin/perl -w
use strict;

###################################################
#It deletes the same values in two different files;#
###################################################

my($filename1,$filename2)=@ARGV;
my %hash;
open(INA,"$filename1");

while(<INA>){
    chomp;
    my @data = split("\t",$_);
    $hash{$data[0]} = 1;
}

close INA;
open(INB,"$filename2");
while(<INB>){
    chomp;
    my @tmp = split(" ",$_);
    print $_,"\n" unless exists $hash{"$tmp[3]"};
}
close INB;