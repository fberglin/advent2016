#!/usr/bin/perl

use Data::Dumper;

$fav = 1350;

$x_final = 31;
$y_final = 39;
# $x_final = 2;
# $y_final = 4;

$x_start = 1;
$y_start = 1;

$x_max = 50;
$y_max = 50;
# $x_max = 10;
# $y_max = 10;
# x*x + 3*x + 2*x*y + y + y*y

@floor = ();

for $y (0 ... $y_max) {
  for $x (0 ... $x_max) {
    $sum = $x*$x + 3*$x + 2*$x*$y + $y + $y*$y + $fav;
    $bin = sprintf("%b", $sum);
    $ones = scalar(grep(/1/, split(//, $bin)));
    $zeroes = length($bin) - $ones;
    if ($ones % 2 == 0) {
      $floor[$y][$x] = " ";
    } else {
      $floor[$y][$x] = "#";
    }
    if ($x == $x_start && $y == $y_start) {
      $floor[$y][$x] = "*";
    }
    if ($x == $x_final && $y == $y_final) {
      $floor[$y][$x] = 'X';
    }
  }
}

$count = 0;
for $y_final (0 ... $y_max) {
  for $x_final (0 ... $x_max) {

    if ($floor[$y_final][$x_final] eq "#") {
      next;
    }

    %path = ();
    $path{"$y_final,$x_final"} = 0;

    $cont = 1;
    while ($cont == 1) {
      $can_continue = 0;
      for $pos (keys %path) {
        ($y,$x) = split(/,/, $pos);
        $w = $path{$pos}+1;

        if ($floor[$y][$x] eq "*") {
          if ($path{$pos} <= 50) {
            $count++;
          }
          print "Found $y,$x from $y_final,$x_final: d: $path{$pos}. Current count: $count\n";
          $cont = 0;
          $can_continue = 1;
          last;
        }

        @cand = (join(",", $y-1, $x), join(",", $y+1, $x), join(",", $y, $x-1), join(",", $y, $x+1));
        for $c (@cand) {
          ($y,$x) = split(/,/, $c);
          if ($x < 0 or $y < 0 or $x >= $x_max or $y > $y_max) {
            next;
          }
          if ($floor[$y][$x] eq "#") {
            next;
          }
          if (defined($path{"$y,$x"}) and $path{"$y,$x"} < $w) {
            next;
          }
          if (defined($path{"$y,$x"}) and $path{"$y,$x"} == $w) {
            next;
          }
          $can_continue = 1;
          $path{"$y,$x"} = $w;
        }
      }

      if ($can_continue == 0) {
        $cont = 0;
        last;
      }
    }
  }
}

print "Number of paths within 50 steps: $count\n";


