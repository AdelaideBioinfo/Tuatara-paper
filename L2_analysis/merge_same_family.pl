#!/usr/bin /perl -w
use warnings;

my ( @gid, %hash );

while (<>) {
    chomp;
    @gid = split("\t",$_);
    $hash{$gid[0]} = $_;
    last if eof;
}

while (<>) {
    chomp;
    @gid = split("\t",$_);
    print +( join "\t", @gid, $hash{ $gid[1] } ), "\n" if exists $hash{$gid[1]};
}
