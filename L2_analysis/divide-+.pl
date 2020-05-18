#!/usr/bin/perl -w
use strict;

my ($filename) = @ARGV;
my $n=0;
open(IN,"$filename");
my $out1 = $filename."_forward";
my $out2 = $filename."_comple";
open(OUTA,">$out1");
open(OUTB,">$out2");

while(<IN>){
    $n++;
    my @data = split(" ",$_);
    if($data[6] eq 'd'){
        print OUTA $_;
    }
    elsif($data[6] eq 'c'){
        print OUTB $_;
    }
    else{
        print $n;
    }
}

close OUTA;
close OUTB;
close IN;