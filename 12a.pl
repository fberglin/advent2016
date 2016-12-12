#!/usr/bin/perl

use Data::Dumper;

open($fh, "< 12.input");
# open($fh, "< 12.test");

@list = ();

while ($input = <$fh>) {

  if ($input =~ m/^#/) {
    next;
  }

  chomp($input);
  push(@list, [ split(/ /, $input) ]);
}

%vars = ();
$line = 0;

for ($i=0; $i<scalar(@list); $i++) {

  $cmd = @{$list[$i]}[0];
  $arg1 = @{$list[$i]}[1];
  $arg2 = @{$list[$i]}[2];

  print "i: ", $i+1, ", cmd: '$cmd', arg1: '$arg1', arg2 '$arg2' :: ";

  if ($cmd eq "cpy") {
    if (defined($vars{$arg1})) {
      $vars{$arg2} = $vars{$arg1};
      print "copy var: $arg1: $vars{$arg1} to $arg2: $vars{$arg2}\n";
    } else {
      $vars{$arg2} = $arg1;
      print "set var: $arg2: $vars{$arg2}\n";
    }

  } elsif ($cmd eq "inc") {
    $vars{$arg1}++;
    print "var: $arg1 $vars{$arg1}\n";

  } elsif ($cmd eq "dec") {
    $vars{$arg1}--;
    print "var: $arg1 $vars{$arg1}\n";

  } elsif ($cmd eq "jnz") {
    $test = 0;
    if ($arg1 =~ m/^\d+$/) {
      print "num: $arg1: ";
      $test = $arg1;
    } else {
      print "var: $arg1: ";
      $test = $vars{$arg1};
    }
    if ($test != 0) {
      $i += ($arg2 - 1);
      print "$vars{$arg1}: i: $i\n";
    } else {
      print "$vars{$arg1}: Ignore\n";
    }

  } else {
    print "Unknown command: '$cmd'\n";
  }

  if ($line++ == 1000) {
    # last;
  }
}

for $var (keys %vars) {
  print "$var: $vars{$var}\n";
}


