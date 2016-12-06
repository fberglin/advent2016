#!/usr/bin/perl

open($fh, "< 4.input");

$line = 0;
%count = ();
$sum = 0;

while (<$fh>) {
  $line++;
  # print;
  chomp;
  m/(\d+)\[(\w+)\]/;
  $id = $1;
  $checksum = $2;
  # print "$id, $checksum\n";
  @letters = split(//);

  foreach $letter (@letters) {
    if ($letter =~ m/[-\d\[\]]/) {
      # print "Skipping $letter\n";
      next;
    }
    $count{$letter}++;
  }

  $number_of_letters = 0;
  $cs = "";
  foreach $letter (sort { $count{$b} <=> $count{$a} || $a cmp $b } keys %count) {
    if ($number_of_letters++ == 5) {
      last;
    }
    # print "$letter: $count{$letter}\n";
    $cs .= $letter;
  }

  if ($checksum eq $cs) {
    print "$id, $checksum\n";
    $sum += $id;
  }

  if ($line == 10) {
    # last;
  }
  %count = ();
}

print "Sum: $sum\n";



