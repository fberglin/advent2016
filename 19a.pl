#!/usr/bin/perl

use Data::Dumper;

$number = 3014603;
# $number = 5;

for $elf (0 ... $number) {
  $elfs[$elf] = 1;
}

$this = 0;
$that = 0;

$count = 0;

while(1) {

  # if (++$count == 10) { last; }

  # print "-> This: $this ($elfs[$this])";

  if ($elfs[$this] == 0) {
    # No packets.
    # print ": No gifts. Ignore\n";
    $this = ($this + 1) % $number;
    next;
  }

  $that = ($this + 1) % $number;

  # print ", That: $that ($elfs[$that])\n";

  while ($elfs[$that] == 0) {
    $that = (($that++) + 1) % $number;

    if ($this == $that) {
      print "And the winner is: ", $this + 1, "!\n";
      exit;
    }
  }

  # print "Elf $that has $elfs[$that] gifts. Take them!\n";

  if ($elfs[$that] > 0) {
    $elfs[$this] += $elfs[$that];
    $elfs[$that] = 0;
  }

  $this = ($this+1) % $number;
}

