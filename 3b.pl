#!/usr/bin/perl

open($fh, "< 3.input");
# open($fh, "< 3.test");

$impossible = 0;
$possible = 0;
$line = 0;
@collection = (());

while (<$fh>) {
  s/^ +//;
  s/ +$//;
  chomp;
  $collection[$line%3] = [ split(/ +/) ];

  $line++;

  if ($line % 3 == 0) {
    foreach $i (0...2) {
      @edges = sort { $a <=> $b } ($collection[0][$i], $collection[1][$i], $collection[2][$i]);
      print ">$i,", scalar(@edges),",$edges[0],$edges[1],$edges[2]";

      if (($edges[0] + $edges[1]) <= $edges[2]) {
        print ": No\n";
        $impossible++;
      } else {
        print ": Yes\n";
        $possible++;
      }
    }
  }
}
print "Impossible triangles: $impossible\n";
print "Possible triangles: $possible\n";


