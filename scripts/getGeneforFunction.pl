#!/usr/bin/perl -w
#define hash

$numArgs = @ARGV;
if($numArgs != 3)
{   
	print "the number of parameters is not correct!";
	exit(1);
}

$in = "$ARGV[0]";		# functionnew
$gofile = "$ARGV[1]";	# function
$out = "$ARGV[2]";		# output

open(FILE, "$in") || die("Couldn't read file $in\n");  
@array=<FILE>;
close FILE;

open(INFILE, "$gofile") || die("Couldn't read file $gofile\n");  
@go=<INFILE>;
close INFILE;

open(OUTFILE, ">$out") || die("Couldn't open file $out\n"); 

%h1=();

foreach $line (@array) 
{
	chomp($line);

	if (length($line)>1) 
	{
		@i=split(/\t/,$line);

		if (exists($h1{$i[0]})) 
		{
		}
		else
		{
			$h1{$i[0]}="";
		}
	}
}

$genename="";

foreach $l (@go) 
{
	chomp($l);
	if (">" eq substr($l,0,1)) 
	{
		$genename=substr($l,1);
	}
	if ("GO" eq substr($l,0,2)) 
	{
		$s1=substr($l,14);
		$s2=substr($s1,0,index($s1,";"));
        if(!exists($h1{$s2}))
		{
			die "Doesn't find ".$s2."!\n";
		}
		$h1{$s2}=$h1{$s2}.$genename.";";
	}
}

=podwhile(my ($key, $val) = each(%h1)) 
{ 
	$val1=substr($val,0,length($val)-1);
	print OUTFILE $key."\t".$val1."\n";
}
=cut

foreach $line (@array) 
{
	chomp($line);

	if (length($line)>1) 
	{
		@i=split(/\t/,$line);

		if (exists($i[2]) && exists($i[3])) 
		{
			$val=substr($h1{$i[0]},0,length($h1{$i[0]})-1);
			print OUTFILE "$i[0]\t$i[1]\t$i[3]\t$val\t$i[2]\n";
		}
	}
	else
	{
		print OUTFILE $line."\n";
	}
}

close OUTFILE;
