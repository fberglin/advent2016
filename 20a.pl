#!/usr/bin/perl

use Data::Dumper;

open($fh, "< 20.input");
# open($fh, "< 20.test");

@list = ();

while ($input = <$fh>) {

  if ($input =~ m/^#/) {
    next;
  }

  chomp($input);
  push(@list, [ split(/-/, $input) ]);
}

$smallest = 0;
$found = 1;

while($found == 1) {
  $found = 0;
  for $range (@list) {
    if ($smallest >= $range->[0] and $smallest < $range->[1] or
        $smallest == $range->[0]-1) {
    # if ($range->[0] < $smallest) {
      print "Found $range->[0], less than $smallest. New smallest: $range->[1]\n";
      $smallest = $range->[1];
      $found = 1;
    }
  }
}

# smallest is the largest blocked. Increment to find first free.
$smallest++;

print $smallest, ": ",
      $smallest >> 24 & 0xff, ".",
      $smallest >> 16 & 0xff, ".",
      $smallest >> 8 & 0xff, ".",
      $smallest >> 0 & 0xff, "\n";

