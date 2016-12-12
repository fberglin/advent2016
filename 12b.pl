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

%vars = ( 'c' => 1 );
$line = 0;

for ($i=0; $i<scalar(@list); $i++) {

  $cmd = @{$list[$i]}[0];
  $arg1 = @{$list[$i]}[1];
  $arg2 = @{$list[$i]}[2];

  if ($cmd eq "cpy") {
    if (defined($vars{$arg1})) {
      $vars{$arg2} = $vars{$arg1};
    } else {
      $vars{$arg2} = $arg1;
    }

  } elsif ($cmd eq "inc") {
    $vars{$arg1}++;

  } elsif ($cmd eq "dec") {
    $vars{$arg1}--;

  } elsif ($cmd eq "jnz") {
    $test = 0;
    if ($arg1 =~ m/^\d+$/) {
      $test = $arg1;
    } else {
      $test = $vars{$arg1};
    }
    if ($test != 0) {
      $i += ($arg2 - 1);
    }

  } else {
    print "Unknown command: '$cmd'\n";
  }
}

for $var (keys %vars) {
  print "$var: $vars{$var}\n";
}

