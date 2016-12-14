#!/usr/bin/perl

use Digest::MD5 qw(md5 md5_hex md5_base64);

# Flush stdout on write
$|++;

$salt = "yjdafjpo";
# $salt = "abc";

$index = 0;

%candidates = ();
@hashes = ();
$count = 0;

while (1) {
  $data = $salt . $index;
  $digest = md5_hex($data);
  for (1 ... 2016) {
    $digest = md5_hex($digest);
  }
  # print "Digest: $index: $digest\n";

  if ($digest =~ m/((\w)\2\2)/g) {
    print "Found three consecutive at $index: ", $digest, ", pos: ", pos($digest), ", str: $1\n";

    $str = "$2"x5;
    for ($i=$index+1; $i<=$index+1000; $i++) {
      $data = $salt . $i;
      $digest = md5_hex($data);
      for (1 ... 2016) {
        $digest = md5_hex($digest);
      }

      # print "-> Digest: $i: $digest\n";
      if ($digest =~ m/($str)/g) {
        $count++;
        print "-> Found match $count for $index at $i: ", $digest, ", pos: ", pos($digest), ", str: $1\n";
        last;
      }
    }
  }

  if ($count == 64) {
    last;
  }

  if ($index == 100) {
    # last;
  }

  $index++;
}

print "Last key: $index\n";

