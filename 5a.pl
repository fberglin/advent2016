#!/usr/bin/perl

use Digest::MD5 qw(md5 md5_hex md5_base64);

$|++;

$input = "ffykfhsq";

$index = 0;

$password = "";
$chars = 0;

while (1) {
  $data = $input . $index;
  $digest = md5_hex($data);
  if (substr($digest, 0, 5) eq "00000") {
    print "+";
    print "\nFound one at $index: ", $digest, "\n";
    $password .= substr($digest, 5, 1);
    $chars++;
  }

  if ($chars == 8) {
    last;
  }

  if ($index % 100000 == 0) {
    print "*";
  }

  $index++;
}

print "Password: $password\n";

