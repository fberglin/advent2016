#!/usr/bin/perl

use Data::Dumper;

open($fh, "< 6.input");

@cols = ();
%count = ();

while (<$fh>) {
  chomp;
  @letters = split(//);

  for $i (0...@letters-1) {
    $cols[$i]{$letters[$i]}++;
  }
}

foreach $col (@cols) {
  foreach $letter (sort { $col->{$a} <=> $col->{$b} } keys %{$col}) {
    print "Letter: $letter, freq: $col->{$letter}\n";
    last;
  }
}
print "\n";

print "Message ";
foreach $col (@cols) {
  print [ sort { $col->{$a} <=> $col->{$b} } keys %{$col} ]->[0];
}
print "\n";

