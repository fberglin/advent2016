#!/usr/bin/perl

open($fh, "< 7.input");
# open($fh, "< 7b.test");

$line = 0;
$count = 0;

while ($input = <$fh>) {
  chomp($input);
  $snet = $hnet = $input;

  # Clean up SNET by removing HNET components
  $snet =~ s/\[\w+\]/ /g;

  # Clean up HNET by removing SNET components
  $hnet =~ s/\w+\[/ /g;
  $hnet =~ s/\]\w+/ /g;

  # print "$input - $snet\n";
  # print "$input - $hnet\n";

  # Iterate all instances where three letters in a row match
  while ($snet =~ m/((\w)(\w)(\g2))/g) {
    # $s_pos = pos($snet);

    # Ignore it if second and third letter are the same
    if ($2 ne $3) {
      # print "$line: snet: $input > ($s_pos) [$snet]: $1: $2 $3 $4\n";

      # Match HNET with the inverted pattern
      if ($hnet =~ m/($3$4$3)/) {
        # print "$line: hnet: $input > ($s_pos) [$hnet]: $1: $2 $3 $4\n";
        $count++;
        last;
      }
    }
    # Reset matching position to match twice on string like 'abaxa' and 'abab'
    pos($snet) -= 2;
  }
  if ($line == 30) {
    # last;
  }
  $line++;
}

print "Count: $count\n";

