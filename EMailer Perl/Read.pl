use strict;
use warnings;
 
my $filename = 'Send1.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
 
my $body ="";
while (my $row = <$fh>) {
  chomp $row;
  $body = $body.$row."\n";
  #print "$row\n";
}

print "$body";