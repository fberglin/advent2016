#!/usr/bin/perl

$string = "R3, L5, R2, L2, R1, L3, R1, R3, L4, R3, L1, L1, R1, L3, R2, L3, L2, R1, R1, L1, R4, L1, L4, R3, L2, L2, R1, L1, R5, R4, R2, L5, L2, R5, R5, L2, R3, R1, R1, L3, R1, L4, L4, L190, L5, L2, R4, L5, R4, R5, L4, R1, R2, L5, R50, L2, R1, R73, R1, L2, R191, R2, L4, R1, L5, L5, R5, L3, L5, L4, R4, R5, L4, R4, R4, R5, L2, L5, R3, L4, L4, L5, R2, R2, R2, R4, L3, R4, R5, L3, R5, L2, R3, L1, R2, R2, L3, L1, R5, L3, L5, R2, R4, R1, L1, L5, R3, R2, L3, L4, L5, L1, R3, L5, L2, R2, L3, L4, L1, R1, R4, R2, R2, R4, R2, R2, L3, L3, L4, R4, L4, L4, R1, L4, L4, R1, L2, R5, R2, R3, R3, L2, L5, R3, L3, R5, L2, R3, R2, L4, L3, L1, R2, L2, L3, L5, R3, L1, L3, L4, L3";
# $string = "R8, R4, R4, R8";

use Data::Dumper;

@items = split(/, /, $string);

@dir = ( "N", "E", "S", "W" );
@coord_math = ( "x+", "y+", "x-", "y-" );

$facing = 0;
$x = 0;
$y = 0;

$xy{"0,0"} = 0;

foreach $item (@items) {
  $item =~ m/([RL])(\d+)/;
  print $1, ": ", $2, "\n";

  if ($1 eq "R") {
    $facing++;
  } else {
    $facing--;
  }

  $found_it = 0;
  $dir = $facing % 4;
  foreach $i (1 ... $2) {
    if ($xy{"$x,$y"} == 2) {
      $found_it = 1;
      last;
    }
    if ($dir == 0) {
      $x++;
    } elsif ($dir == 1) {
      $y++;
    } elsif ($dir == 2) {
      $x--;
    } else {
      $y--;
    }
    print "Visited: $x,$y\n";
    $xy{"$x,$y"}++;
  }

  if ($found_it == 1) {
    print "Found it at: ", $facing, "(", $dir[$facing%4],  "), ", $x, ", ", $y, "\n";
    print "Total distance: ", abs($x) + abs($y), "\n";
    last;
  }
}

if ($found_it == 0) {
  print "No intersection found\n";
}


