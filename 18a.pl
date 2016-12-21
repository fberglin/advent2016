#!/usr/bin/perl

use Data::Dumper;

$input = ".^^^^^.^^.^^^.^...^..^^.^.^..^^^^^^^^^^..^...^^.^..^^^^..^^^^...^.^.^^^^^^^^....^..^^^^^^.^^^.^^^.^^";
# $input = ".^^.^.^^^^";

@floor = ( [ split(//, $input) ] );

$lines = 40;
# $lines = 10;

# print Dumper @floor;

for $line (1 ... $lines-1) {
  $width = scalar(@{$floor[0]});
  # print "l: $line, w: $width\n";
  @row = ();
  for $pos (0 ... $width-1) {
    $left = ($pos == 0) ? "." : $floor[$line-1]->[$pos-1];
    $center = $floor[$line-1]->[$pos];
    $right = ($pos == $width-1) ? "." : $floor[$line-1]->[$pos+1];

    $result = "";
    if ($left eq "^"  and $center eq "^" and $right eq ".") {
      $result = "^";
    } elsif ($left eq "."  and $center eq "^" and $right eq "^") {
      $result = "^";
    } elsif ($left eq "^"  and $center eq "." and $right eq ".") {
      $result = "^";
    } elsif ($left eq "."  and $center eq "." and $right eq "^") {
      $result = "^";
    } else {
      $result = ".";
    }

    # print "$left $center $right: $result\n";
    push(@row, $result);
  }
  print "-> ", @row, "\n";
  push(@floor, [ @row ]);
}

$safe = 0;

for $line (@floor) {
  for $char (@{$line}) {
    # print $char;
    if ($char eq ".") {
      $safe++;
    }
  }
  # print "\n";
}

print "Safe: $safe\n";


