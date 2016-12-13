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
      # print " ";
    } else {
      $floor[$y][$x] = "#";
      # print "#";
    }
    if ($x == $x_start && $y == $y_start) {
      $floor[$y][$x] = "*";
    }
    # if ($x == 31 && $y == 39) {
    if ($x == $x_final && $y == $y_final) {
      $floor[$y][$x] = 'X';
    }
  }
}

%path = ();
$path{"$y_final,$x_final"} = 0;

print Dumper(%path);

$r = 0;
$cont = 1;
while ($cont == 1) {

  for $pos (keys %path) {
    ($y,$x) = split(/,/, $pos);
    $w = $path{$pos}+1;
    print "w: $w\n";

    if ($floor[$y][$x] eq "*") {
      print "Found start: Length: $path{$pos}\n";
      $cont = 0;
      last;
    }

    print "Examine root: $y,$x: ", $path{"$y,$x"}, "\n";
    @cand = (join(",", $y-1, $x), join(",", $y+1, $x), join(",", $y, $x-1), join(",", $y, $x+1));

    for $c (@cand) {
      ($y,$x) = split(/,/, $c);
      print "Examine candidate: $y,$x: ", $path{"$y,$x"}, ": ";
      if ($x < 0 or $y < 0 or $x >= $x_max or $y > $y_max) {
        print "out of bounds\n";
        next;
      }
      if ($floor[$y][$x] eq "#") {
        print "wall\n";
        $floor[$y][$x] = "!";
        next;
      }
      if ($floor[$y][$x] eq "!") {
        print "examined wall\n";
        next;
      }
      if (defined($path{"$y,$x"}) and $path{"$y,$x"} < $w) {
        print "better path already found to: $y,$x: ", $path{"$y,$x"}, "/$w\n";
        next;
      }
      $path{"$y,$x"} = $w;
      print "assign: $x,$y: ", $path{"$y,$x"}, "\n";
    }
  }
  if ($r++ == 5) {
    # last;
  }
}

for $y (0 ... $y_max) {
  for $x (0 ... $x_max) {
    if ($floor[$y][$x] eq " " and defined($path{"$y,$x"})) {
      # print $path{"$y,$x"};
      print ".";
    } else {
      print "$floor[$y][$x]";
    }
  }
  print "\n";
}

