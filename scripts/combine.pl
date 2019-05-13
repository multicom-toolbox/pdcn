################################################################
#Put the sequences under a folder into a fasta file
#
#Zheng Wang, Oct 28, 2010.
################################################################

use strict;

my $input_folder = $ARGV[0];
my $output_file = $ARGV[1];
my $key = $ARGV[2];

opendir(DIR, $input_folder);
my @files = readdir(DIR);
close(DIR);

open(OUT, ">$output_file");
foreach my $file (@files){
	if(!($file =~ /$key/)){
		next;
	}
	open(IN, "<$input_folder/$file");
	while(<IN>){
		my $line = $_;
		$line =~ s/\n//;
		print OUT $line."\n";
	}
	close(IN);
}
close(OUT);
