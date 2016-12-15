#!/usr/bin/perl

use Data::Dumper;

open($fh, "< 15.input");
# open($fh, "< 15.test");

@discs = ();

while ($input = <$fh>) {

  if ($input =~ m/^#/) {
    next;
  }

  # Disc #1 has 17 positions; at time=0, it is at position 5.
  if ($input =~ /Disc #(\d+) has (\d+) positions; at time=0, it is at position (\d+)./) {
    push(@discs, [ $1, $2, $3 ]);
  }
}

$time = 0;
while (1) {

  $aligned = 1;
  for $disc (@discs) {
    $time_offset = $disc->[0];
    $positions = $disc->[1];
    $start_position = $disc->[2];

    $current = $start_position + $time;

    # print "time: $time, time_offset: $time_offset, positions: $positions, start: $start_position, current: ", $time_offset + $current % $positions;

    if (($start_position + $time + $time_offset) % $positions != 0) {
      # print ": not aligned\n";
      $aligned = 0;
    } else {
      # print ": aligned\n";
    }
  }

  if ($aligned == 1) {
    print "Aligned at time: $time\n";
    last;
  }

  if ($time == 10) {
    # last;
  }

  $time++;

  # print "-"x10, "\n";
}

