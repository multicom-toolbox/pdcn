#!/usr/bin/perl -w

$numArgs = @ARGV;
if($numArgs != 3)
{   
	print "the number of parameters is not correct!";
	exit(1);
}

$in = "$ARGV[0]";
$out = "$ARGV[1]";
$path = "$ARGV[2]";

open(FILE, "$in") || die("Couldn't read file $in\n");  
@array=<FILE>;
close FILE;

open(OUTFILE, ">>$out") || die("Couldn't open file $out\n"); 

my $name="";
foreach $line (@array) 
{
	if (">" eq substr($line,0,1)) 
	{
		print OUTFILE $line;
		chomp($line);

		$name=substr($line,1);
	}
	else
	{	
		print OUTFILE $line;

		$filename="$name.swiss_prot_DR";
		open(PROFILE, "$path/$filename") || die("Couldn't read file $path/$filename\n");
		@profile=<PROFILE>;
		close PROFILE;
		
		foreach $proline (@profile) 
		{
			if ("GO" eq substr($proline,5,2)) 
			{
				print OUTFILE substr($proline,9);
			}
		}
		print OUTFILE "\n";
	}
}
close OUTFILE;