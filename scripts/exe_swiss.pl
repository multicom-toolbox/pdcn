#!/usr/bin/perl -w
$GLOBAL_PATH='/storage/htc/bdm/jh7x3/PDCN_github/pdcn/';

$numArgs = @ARGV;
if($numArgs != 3)
{   
	print "the number of parameters is not correct!";
	exit(1);
}

$seq = "$ARGV[0]";
$in = "$ARGV[1]";
$out = "$ARGV[2]";


open(FILE, "$seq") || die("Couldn't read file $seq\n");  
@array=<FILE>;
close FILE;

$name="";

foreach $line (@array) 
{
	if (">" eq substr($line,0,1)) 
	{
		chomp($line);
		$name=$line."00";
	}
	else
	{
   print "Saving to $in/temp.fasta\n";
		open(TEM, ">$in/temp.fasta") || die("Couldn't open file temp.fasta\n"); 
		print TEM $name."\n".$line.$name."\n".$line;
		close TEM;

		#`perl ./blast_search_swiss_prot.pl $in/temp.fasta ./blast-2.2.17/bin/blastpgp $in $out ../swiss_prot_2010/uniprot_sprot.fasta ../swiss_prot_2010/uniprot_sprot.dat $in/swiss_prot_euk_1.LOG ../swiss_prot_2010/uniprot_sprot.fasta`;
		print "perl $GLOBAL_PATH/scripts/blast_search_swiss_prot.pl $in/temp.fasta $GLOBAL_PATH/programs/blast-2.2.26/bin/blastpgp $in $out $GLOBAL_PATH/database/swiss_prot/uniprot_sprot.fasta $GLOBAL_PATH/database/swiss_prot/uniprot_sprot.dat $in/swiss_prot_euk_1.LOG $GLOBAL_PATH/database/swiss_prot/uniprot_sprot.fasta\n";
    `perl $GLOBAL_PATH/scripts/blast_search_swiss_prot.pl $in/temp.fasta $GLOBAL_PATH/programs/blast-2.2.26/bin/blastpgp $in $out $GLOBAL_PATH/database/swiss_prot/uniprot_sprot.fasta $GLOBAL_PATH/database/swiss_prot/uniprot_sprot.dat $in/swiss_prot_euk_1.LOG $GLOBAL_PATH/database/swiss_prot/uniprot_sprot.fasta`;

		#`rm $in/temp.fasta`;
	}
}
