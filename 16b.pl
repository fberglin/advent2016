#!/usr/bin/perl

use Data::Dumper;

$a = "01110110101001000";
# $a = "10000";

$len = 35651584;
# $len = 20;

while (length($a) < $len) {
  $b = reverse $a;

  $b =~ tr/01/10/;

  $a = $a . "0" . $b;
}

# print $a, "\n";

$data = substr($a, 0, $len);

# print $data, "\n";

$chk = "";
$temp = $data;
while (1) {
  # print "d: $temp\n";
  while ($temp =~ m/(\d)(\d)/g) {
    if ($1 == $2) {
      $chk .= "1";
    } else {
      $chk .= "0";
    }
  }

  # print "c: $chk\n";
  if ((length($chk) % 2) == 1) {
    last;
  } else {
    $temp = $chk;
    $chk = "";
  }
}

print "Final checksum: $chk\n";

