#!/usr/bin/perl

use Data::Dumper;

open($fh, "< 10.input");
# open($fh, "< 10.test");

$line = 0;
$count = 0;

%inv = ();
%inst = ();

%output = ();

while ($input = <$fh>) {
  if ($input =~ m/^#/) {
    next;
  }

  # print $input;
  chomp($input);

  # bot 76 gives low to bot 191 and high to bot 21
  # bot 74 gives low to output 18 and high to bot 130
  if ($input =~ m/bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)/) {
    $inst{$1} = [ "$2", "$3", "$4", "$5" ];
  }
  # value 41 goes to bot 164
  elsif ($input =~ m/value (\d+) goes to bot (\d+)/) {
    print "Push $1 to $2\n";
    push(@{$inv{$2}}, $1);
  }
  else {
    print "Unknown: $input\n";
  }
}

for $bot (keys %inv) {
  print "Bot: $bot(", scalar(@{$inv{$bot}}), "): ";
  for $chip (sort { $a <=> $b } @{$inv{$bot}}) {
    print "$chip ";
  }
  print "\n";
}

$one = 1;
while ($one == 1) {
  print "-\n";
  $one = 0;
  for $bot (sort { $a <=> $b } keys %inst) {
    if (scalar(@{$inv{$bot}}) == 2) {
      @chips = sort { $a <=> $b } @{$inv{$bot}};
      if ($chips[0] == 17 and $chips[1] == 61) {
        print "Found bot: $bot\n";
        exit;
      }
      if ($inst{$bot}[0] eq "bot") {
        push(@{$inv{$inst{$bot}[1]}}, $chips[0]);
      } else {
        push(@{$out{$inst{$bot}[1]}}, $chips[0]);
      }
      if ($inst{$bot}[2] eq "bot") {
        push(@{$inv{$inst{$bot}[3]}}, $chips[1]);
      } else {
        push(@{$out{$inst{$bot}[3]}}, $chips[1]);
      }
      print "$bot: low($chips[0]) to $inst{$bot}[0]($inst{$bot}[1])\n";
      print "$bot high($chips[1]) to $inst{$bot}[2]($inst{$bot}[3])\n";
      @{$inv{$bot}} = ();
      $one = 1;
    }
  }
}

# print Dumper(@grid);

