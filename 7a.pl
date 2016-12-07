#!/usr/bin/perl

open($fh, "< 7.input");
# open($fh, "< 7a.test");

$line = 0;
$count = 0;

while ($input = <$fh>) {
  @parts = split(/\[|\]/, $input);

  # print "@parts\n";

  $i = 0;
  $valid = 0;
  $invalid = 0;
  for $part (@parts) {
    if ($part =~ m/((\w)(\w)(\g3)(\g2))/) {
      if ($2 ne $3) {
        print "$line: $1: $2 $3 $4 $5";
        if ($i % 2 == 0) {
          print ": Yes > $input\n";
          $valid = 1;
        } else {
          print ": No > $input\n";
          $invalid = 1;
        }
      }
    }
    $i++;
  }
  if ($valid == 1 and $invalid == 0) {
    $count++;
  }

  if ($line == 30) {
    # last;
  }
  $line++;
}

print "Count: $count\n";

