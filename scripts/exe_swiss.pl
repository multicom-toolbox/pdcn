#!/usr/bin/perl -w

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
		open(TEM, ">>$in/temp.fasta") || die("Couldn't open file temp.fasta\n"); 
		print TEM $name."\n".$line.$name."\n".$line;
		close TEM;

		#`perl ./blast_search_swiss_prot.pl $in/temp.fasta ./blast-2.2.17/bin/blastpgp $in $out ../swiss_prot_2010/uniprot_sprot.fasta ../swiss_prot_2010/uniprot_sprot.dat $in/swiss_prot_euk_1.LOG ../swiss_prot_2010/uniprot_sprot.fasta`;
		`perl ./blast_search_swiss_prot.pl $in/temp.fasta ./blast-2.2.17/bin/blastpgp $in $out ../swiss_prot_2016/uniprot_sprot.fasta ../swiss_prot_2016/uniprot_sprot.dat $in/swiss_prot_euk_1.LOG ../swiss_prot_2016/uniprot_sprot.fasta`;

		`rm $in/temp.fasta`;
	}
}
