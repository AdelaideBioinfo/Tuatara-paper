#!/usr/bin/perl -w
use strict;

#############################################
#### the aim of this script is to get    ####
#### different gid from human and mouse  ####
#############################################

my ($file1,$file2) = @ARGV;
open(INA,"$file1");
open(INB,"$file2");
my ($gid,$family);
my %hash;

while (<INA>) {
    chomp;
    my @data = split(" ",$_);    
    $gid = $data[0];
    $hash{$gid} = $gid;
#    print "$gid\n";
}

$/=">";
while(<INB>) {
    chomp;
    $_=~s/>//;
    next if ($_ eq "");
    my @single = split("\n",$_,2);
    if ($single[0] =~ /(family[\w\_]+)/){
        $family = $1;
        print ">".$single[0]."\n".$single[1] if exists $hash{$family};
    }
}

close INA;
close INB;