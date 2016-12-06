#!/usr/bin/perl

use Digest::MD5 qw(md5 md5_hex md5_base64);

$|++;

$input = "ffykfhsq";

$index = 0;

@password = ( "*", "*", "*", "*", "*", "*", "*", "*" );
$chars = 0;
$print = 0;

print "Solving password. Please wait.\n";
print "\rPassword: ", @password;

$fancy = 1;

while (1) {
  $data = $input . $index;
  $digest = md5_hex($data);
  if (substr($digest, 0, 5) eq "00000") {
    $pos = substr($digest, 5, 1);
    if (hex($pos) <= 7) {
      if ($password[$pos] eq "*") {
        $password[$pos] = substr($digest, 6, 1);
        $chars++;
        $print = 1;
      }
    }
  }

  if ($fancy == 2) {
    print "\rPassword: ";
    foreach $letter (@password) {
      if ($letter eq "*") {
        printf("%x", rand(15));
      } else {
        print $letter;
      }
    }
  } elsif ($fancy == 1) {
    if ($print == 1) {
      print "\rPassword: ", @password;
      $print = 0;
    }
  }

  if ($chars == 8) {
    last;
  }

  $index++;
}

print "\nDone!\n";

