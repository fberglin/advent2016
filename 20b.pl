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

@list = sort { $a->[0] <=> $b->[0] or $a->[1] <=> $b->[1] } @list;

$found = 1;

@new = ();

$i = 0;
while($found == 1) {
  $found = 0;
  # print "-"x30, "\n";
  for $range (@list) {
    # print "Processing: $range->[0] - $range->[1]\n";
    $new = 1;
    for $r (@new) {

      if ($range->[0] >= $r->[0] && $range->[1] <= $r->[1]) {
        # print "Range already exists: $r->[0] >= $range->[0] && $r->[1] <= $range->[1]\n";
        $new = 0;
        next;
      }

      elsif ($range->[0] >= $r->[0] && $range->[0] <= $r->[1]) {
        # print "Low $range->[0] within range: $r->[0] - $r->[1]\n";
        $r->[0] = $range->[0] < $r->[0] ? $range->[0] : $r->[0];
        $r->[1] = $range->[1] > $r->[1] ? $range->[1] : $r->[1];
        # print "New range: $r->[0] - $r->[1]\n";
        $found = 1;
        $new = 0;
      }

      elsif ($range->[1] >= $r->[0] && $range->[1] <= $r->[1]) {
        # print "High $range->[1] within range: $r->[0] - $r->[1]\n";
        $r->[0] = $range->[0] < $r->[0] ? $range->[0] : $r->[0];
        $r->[1] = $range->[1] > $r->[1] ? $range->[1] : $r->[1];
        # print "New range: $r->[0] - $r->[1]\n";
        $found = 1;
        $new = 0;
      }

      elsif ($range->[0] == $r->[0]+1) {
        # print "Increase upper range adj: $r->[0] - $r->[1]. New max $range->[1]\n";
        $found = 1;
        $new = 0;
        $r->[1] = $range->[1];
      }

      elsif ($range->[1] == $r->[0]-1) {
        # print "Increase lower range adj: $r->[0] - $r->[1]. New min $range->[0]\n";
        $found = 1;
        $new = 0;
        $r->[0] = $range->[0];
      }
    }

    if ($new == 1) {
      # print "Adding range: $range->[0] - $range->[1]\n";
      push(@new, $range);
      $found = 1;
      $new = 0;
    }
  }

  # if ($i++ == 20) { last; };
}

%sort = ();
@uniq = ();

for $range (sort { $a->[0] <=> $b->[0] } @new) {
  if (! defined($sort{$range->[0],$range->[1]})) {
    push(@uniq, $range);
    $sort{$range->[0],$range->[1]} = 1;
  }
}

$sum = 0;
for $i (1 ... scalar(@uniq)-1) {
  # print "$uniq[$i]->[0] - $uniq[$i]->[1]\n";
  # print "$uniq[$i]->[0] - $uniq[$i-1]->[1] = ", $uniq[$i]->[0] - $uniq[$i-1]->[1] - 1, "\n";
  $sum += $uniq[$i]->[0] - $uniq[$i-1]->[1] - 1;

}

# print Dumper(@uniq)

print "Allowed: $sum\n";




