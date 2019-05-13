#!/usr/bin/perl -w
#define hash

$numArgs = @ARGV;
if($numArgs != 3)
{   
	print "the number of parameters is not correct!";
	exit(1);
}

$in		= "$ARGV[0]";	#function.txt
$gofile = "$ARGV[1]";	#go.fasta
$out	= "$ARGV[2]";	#functionnew.txt

open(FILE, "$in") || die("Couldn't read file $in\n");  
@array=<FILE>;
close FILE;

open(INFILE, "$gofile") || die("Couldn't read file $gofile\n");  
@go=<INFILE>;
close INFILE;

open(OUTFILE, ">>$out") || die("Couldn't open file $out\n"); 
print OUTFILE "function_id\t";
print OUTFILE "function_name\t";
print OUTFILE "namespace\t";
print OUTFILE "# genes\t";
print OUTFILE "function_definition\n";

%h1=();

foreach $line (@array) {
	chomp($line);
	if (substr($line,0,3) eq "GO:") {
		$id=substr($line,0,index($line,";"));
		if (exists($h1{$id})) {
			$h1{$id}+=1;
		}
		else{
			$h1{$id}=1;
		}
	}
}

$id="";
$name="";
$namespace="";
$def="";
$flag=0;
foreach $line (@go) {
	chomp($line);
	if (substr($line,0,3) eq "id:") {
		$id=substr($line,index($line,"GO:"));
		if (exists($h1{$id})) {
			$flag=1;
		}
		else{
			$flag=0;
		}
	}
	if (substr($line,0,5) eq "name:") {
		$name=substr($line,6);
	}
	if (substr($line,0,10) eq "namespace:") {
		$namespace=substr($line,11);
	}
	if (substr($line,0,4) eq "def:") {
		$def=substr($line,5);

		if ($flag==1) {
			print OUTFILE "$id\t";
			print OUTFILE "$name\t";
			print OUTFILE "$namespace\t";
			print OUTFILE "$h1{$id}\t";
			print OUTFILE "$def\n";
		}
	}
}
close OUTFILE;

