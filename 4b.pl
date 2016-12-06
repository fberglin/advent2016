#!/usr/bin/perl

open($fh, "< 4.input");

$line = "";
%count = ();
$sum = 0;

while (<$fh>) {
  $line++;
  # print;
  chomp;
  m/(\d+)\[(\w+)\]/;
  $id = $1;
  $checksum = $2;
  # print "$id, $checksum\n";
  @letters = split(//);

  foreach $letter (@letters) {
    if ($letter =~ m/[-\d\[\]]/) {
      next;
    }
    $count{$letter}++;
  }

  $number_of_letters = 0;
  $cs = "";
  foreach $letter (sort { $count{$b} <=> $count{$a} || $a cmp $b } keys %count) {
    if ($number_of_letters++ == 5) {
      last;
    }
    $cs .= $letter;
  }

  if ($checksum eq $cs) {
    # print "$id, $checksum\n";
    $sum += $id;
    s/-/ /g;
    s/\d+.*$//;
    # print "<"; print; print "($id: ", $id % 26, ")\n";
    @pre = unpack("C*");
    @post = ();
    foreach $char (@pre) {
      if ($char == ord(" ")) {
        push(@post, $char);
        next;
      }
      $char += $id % 26;
      if ($char > ord('z')) {
        $char -= 26;
      }
      push(@post, $char);
    }
    $string = pack("C*", @post);
    print "> $string: $id\n";
  }

  %count = ();
}

