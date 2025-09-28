use strict;
my %name2id = {};
open F, "../mapping.txt";
my $i = 1;
while (<F>)
{
	chomp;
	my ($a, $b) = split;
#	print "$i ##$b##\n";
	$name2id{$b} = $i;
	$i++;
}
close F;

while (<>)
{
	chomp;
	my ($name, $rest) = split(/_/, $_, 2);
	#print "$name##$rest\n";
#       	print "$name2id{$name}##$name##$rest\n";
	print "mv $_ $name2id{$name}_$rest\n";
}	
  
