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
# $x_max = 20;
# $y_max = 20;
# x*x + 3*x + 2*x*y + y + y*y

@floor = ();

for $y (0 ... $y_max) {
  for $x (0 ... $x_max) {
    $sum = $x*$x + 3*$x + 2*$x*$y + $y + $y*$y + $fav;
    # print "$x,$y: $sum\n";
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

%path = ();
$path{"$y_final,$x_final"} = 0;

$cont = 1;
while ($cont == 1) {
  for $pos (keys %path) {
    ($y,$x) = split(/,/, $pos);
    $w = $path{$pos}+1;

    if ($floor[$y][$x] eq "*") {
      $cont = 0;
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
      $path{"$y,$x"} = $w;
    }
  }
}

$x = $x_start;
$y = $y_start;
$y_min = $y_start;
$x_min = $x_start;

while (1) {
  @cand = (join(",", $y-1, $x), join(",", $y+1, $x), join(",", $y, $x-1), join(",", $y, $x+1));
  $lowest = 10e6;
  for $c (@cand) {
    ($y,$x) = split(/,/, $c);
    if (!defined($path{"$y,$x"})) {
      next;
    }
    if ($path{"$y,$x"} < $lowest) {
      $lowest = $path{"$y,$x"};
      $y_min = $y;
      $x_min = $x;
    }
  }
  $y = $y_min;
  $x = $x_min;

  if ($floor[$y][$x] eq "X") {
    last;
  } else {
    $floor[$y][$x] = ".";
  }
}

for $x (0 ... $x_max+2) {
  print "-";
}
print "\n";

for $y (0 ... $y_max) {
  print "|";
  for $x (0 ... $x_max) {
    print "$floor[$y][$x]";
  }
  print "|\n";
}

for $x (0 ... $x_max+2) {
  print "-";
}
print "\n";

print "\n";
print "Shortest path: ", $path{"$y_start,$x_start"}, "\n";
