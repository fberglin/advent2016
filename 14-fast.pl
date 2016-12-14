#!/usr/bin/perl

use Digest::MD5 qw(md5 md5_hex md5_base64);

# Flush stdout on write
$|++;

$salt = "yjdafjpo";
# $salt = "abc";

$index = 0;
# $index = 750;

$stop = -1;

$count = 0;

$part2 = 1;

sub digest(@) {
  $data = shift;

  $digest = md5_hex($data);
  if ($part2 != 0) {
    for (1 ... 2016) {
      $digest = md5_hex($digest);
    }
  }
  return $digest;
}

@candidates = ();

while (1) {
  $data = $salt . $index;
  $digest = digest($data);
  # print "Digest: $index: $digest\n";

  while ($digest =~ m/((\w)\2\2\2\2)/g) {
    print "Found five consecutive at $index: ", $digest, ", pos: ", pos($digest), ", str: $2\n";
    $str = $2;
    for $i (0 ... scalar(@candidates)-1) {
      if (!defined($candidates[$i])) {
        next;
      }
      ($char, $org) = split(",", $candidates[$i]);
      # print "Examining '$char' found at $org. Current: $index\n";
      if ($index > $org+1000) {
        $candidates[$i] = undef;
      } elsif ($char eq $str) {
        $count++;
        print "-> Found match $count for $org at $index, str: $str\n";
        $matches{$org} = "$index,$str";
        $candidates[$i] = undef;
      }
    }
  }

  if ($digest =~ m/((\w)\2\2)/g) {
    # print "Found three consecutive at $index: ", $digest, ", pos: ", pos($digest), ", str: $1\n";
    push(@candidates, "$2,$index");
  }

  if ($count >= 64) {
    last;
  }

  if ($index == $stop) {
    last;
  }

  $index++;
}

$count = 0;
for $ix (sort { $a <=> $b } keys %matches) {
  $count++;
  print "Key $count found at: $ix: matches hash at $matches{$ix}\n";
}

print "\n";
print "Last key: ", [ sort { $a <=> $b } keys %matches ]->[63], "\n";

