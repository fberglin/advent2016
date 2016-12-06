#!/usr/bin/perl

use Data::Dumper;

open($fh, "< 6.input");

$line = 0;
@cols = ();
%count = ();

while (<$fh>) {
  chomp;
  @letters = split(//);

  for $i (0...@letters-1) {
    # print "Row: $line: Found: '$letters[$i]'\n";
    $cols[$i]{$letters[$i]}++;
  }

  if ($line == 10) {
    # last;
  }
  $line++;
}

# print Dumper(@cols);

foreach $col (@cols) {
  foreach $letter (sort { $col->{$b} <=> $col->{$a} } keys %{$col}) {
    print "Letter: $letter, freq: $col->{$letter}\n";
  }
}
print "\n";

print "Message: ";
foreach $col (@cols) {
  print [ sort { $col->{$b} <=> $col->{$a} } keys %{$col} ]->[0];
}
print "\n";

