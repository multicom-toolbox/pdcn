#!/usr/bin/perl -w

$numArgs = @ARGV;
if($numArgs != 3)
{   
	print "the number of parameters is not correct!";
	exit(1);
}

$in_swiss = "$ARGV[0]";
$in_go = "$ARGV[1]";
$out = "$ARGV[2]";

open(SFILE, "$in_swiss") || die("Couldn't read file $in_swiss\n");  
@sa=<SFILE>;
close SFILE;

open(GFILE, "$in_go") || die("Couldn't read file $in_go\n");  
@ga=<GFILE>;
close GFILE;

open(OUTFILE, ">>$out") || die("Couldn't open file $out\n"); 

my $id="";
my $outline="";

foreach $sline (@sa) 
{
	if ("GO" eq substr($sline,0,2)) 
	{
		chomp($sline);

		@items=split(/;/,$sline);
		$outline=$items[0].";";
		$id=$items[0];
		$g_id="";

		foreach $gline (@ga) 
		{
			if ("id:" eq substr($gline,0,3)) 
			{
				chomp($gline);
				$g_id=substr($gline,4);
			}
			else
			{
				if ($id eq $g_id) 
				{
					if ("name:" eq substr($gline,0,5)) 
					{
						chomp($gline);
						$outline.=$gline.";";
					}
					if ("namespace:" eq substr($gline,0,10)) 
					{
						chomp($gline);
						$outline.=$gline.";";
					}
					if ("def:" eq substr($gline,0,4)) 
					{
						chomp($gline);
						$outline.=$gline.".";
						last;
					}
				}
			}
		}
		print OUTFILE $outline."\n";
	}
	else
	{
		print OUTFILE $sline;
	}
}

close OUTFILE;