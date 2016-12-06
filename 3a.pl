#!/usr/bin/perl

open($fh, "< 3.input");

$impossible = 0;
$possible = 0;
while ($line = <$fh>) {
  chomp($line);
  print "$line\n";
  @edges = split(/ +/, $line);
  @edges = sort { $a <=> $b } split(/ +/, $line);

  print scalar(@edges),"$edges[0],$edges[1],$edges[2],$edges[3]";
  if (($edges[1] + $edges[2]) <= $edges[3]) {
    print ": No\n";
    $impossible++;
  } else {
    print ": Yes\n";
    $possible++;
  }
}
print "Impossible triangles: $impossible\n";
print "Possible triangles: $possible\n";


