#!/usr/bin/perl

use Data::Dumper;

open($fh, "< 8.input");
# open($fh, "< 8.test");

$line = 0;
$count = 0;
$x_size = 50;
$y_size = 6;

# $x_size = 7;
# $y_size = 3;

@x_start = (0) x $y_size;
@y_start = (0) x $x_size;

@grid = ();

for $y (0 ... $y_size - 1) {
  for $x (0 ... $x_size - 1) {
    $grid[$y][$x] = 0;
  }
}

sub print_grid() {
  for $y (0 ... $y_size - 1) {
    for $x (0 ... $x_size - 1) {
      print $grid[$y][$x];
    }
    print "\n";
  }
}

while ($input = <$fh>) {

  if ($input =~ m/^#/) {
    next;
  }

  if ($input =~ m/rect (\d+)x(\d+)/) {
    print "Rect: $1,$2\n";
    for $y (0 ... $2-1) {
      for $x (0 ... $1-1) {
        $grid[$y][$x] = 1;
      }
    }
  }

  elsif ($input =~ m/rotate (\w+) (\w)=(\d+) by (\d+)/) {
    # print "Rot: $1 $2 $3: $4\n";
    if ($2 eq "x") {
      print "Rot col($3): $4\n";
      $col = $3;
      $steps = $4;
      for $step (0 ... $steps-1)
      {
        @temp = ();
        for $i (0 ... $y_size-1) {
          $temp[$i] = $grid[$i][$col];
        }
        for $i (0 ... $y_size-1) {
          $grid[($i+1)%$y_size][$col] = $temp[$i];
        }
      }
    } else {
      print "Rot row($3): $4\n";
      $row = $3;
      $steps = $4;
      for $step (0 ... $steps-1)
      {
        @temp = ();
        for $i (0 ... $x_size-1) {
          $temp[$i] = $grid[$row][$i];
        }
        for $i (0 ... $x_size-1) {
          $grid[$row][($i+1)%$x_size] = $temp[$i];
        }
      }
    }
  }

  if ($line == 30) {
    # last;
  }
  $line++;
}

# print Dumper(@grid);

print_grid();

for $y (0 ... $y_size - 1) {
  for $x (0 ... $x_size - 1) {
    if ($grid[$y][$x] == 1) {
      $count++;
    }
  }
}

print "Count: $count\n";

