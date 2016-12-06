#!/usr/bin/perl

$string = "R3, L5, R2, L2, R1, L3, R1, R3, L4, R3, L1, L1, R1, L3, R2, L3, L2, R1, R1, L1, R4, L1, L4, R3, L2, L2, R1, L1, R5, R4, R2, L5, L2, R5, R5, L2, R3, R1, R1, L3, R1, L4, L4, L190, L5, L2, R4, L5, R4, R5, L4, R1, R2, L5, R50, L2, R1, R73, R1, L2, R191, R2, L4, R1, L5, L5, R5, L3, L5, L4, R4, R5, L4, R4, R4, R5, L2, L5, R3, L4, L4, L5, R2, R2, R2, R4, L3, R4, R5, L3, R5, L2, R3, L1, R2, R2, L3, L1, R5, L3, L5, R2, R4, R1, L1, L5, R3, R2, L3, L4, L5, L1, R3, L5, L2, R2, L3, L4, L1, R1, R4, R2, R2, R4, R2, R2, L3, L3, L4, R4, L4, L4, R1, L4, L4, R1, L2, R5, R2, R3, R3, L2, L5, R3, L3, R5, L2, R3, R2, L4, L3, L1, R2, L2, L3, L5, R3, L1, L3, L4, L3";

@items = split(/, /, $string);

@dir = ( "N", "E", "S", "W" );
@coord_math = ( "x+", "y+", "x-", "y-" );

$facing = 0;
$x = 0;
$y = 0;

foreach $item (@items) {
  $item =~ m/([RL])(\d+)/;
  # print $1, ": ", $2, "\n";

  if ($1 eq "R") {
    $facing++;
  } else {
    $facing--;
  }

  $dir = $facing % 4;
  if ($dir == 0) {
    $x += $2;
  } elsif ($dir == 1) {
    $y += $2;
  } elsif ($dir == 2) {
    $x -= $2;
  } else {
    $y -= $2;
  }

  # print $facing, "(", $dir[$facing],  "), ", $x, ", ", $y, "\n";
}

print $facing, "(", $dir[$facing],  "), ", $x, ", ", $y, "\n";

print "Total distance: ", abs($x) + abs($y), "\n";

