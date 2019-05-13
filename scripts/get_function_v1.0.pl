#!/usr/bin/perl -w

$numArgs = @ARGV;
if($numArgs != 3)
{   
	print "the number of parameters is not correct!";
	exit(1);
}

$in = "$ARGV[0]";
$gofile = "$ARGV[1]";
$out = "$ARGV[2]";

open(FILE, "$in") || die("Couldn't read file $in\n");  
@array=<FILE>;
close FILE;

open(INFILE, "$gofile") || die("Couldn't read file $gofile\n");  
@go=<INFILE>;
close INFILE;

open(OUTFILE, ">>$out") || die("Couldn't open file $out\n"); 

my @ps=();
my @fs=();
my @cs=();
my @pc=();
my @fc=();
my @cc=();
$p=0;
$f=0;
$c=0;

foreach $line (@array) 
{
	if ("GO" eq substr($line,0,2)) 
	{
		chomp($line);
		@items=split(/;/,$line);
		$item=$items[1];
		if ("P" eq substr($item,1,1)) 
		{
			if ($p==0) 
			{
				$ps[$p]=substr($item,1);
				$pc[$p]=1;
				$p++;
			}
			else
			{
				$flag=0;
				$kp=0;
				foreach $pline (@ps)
				{
					if ($ps[$kp] eq substr($item,1))
					{
						$flag=1;
						last;				
					}
					$kp++;
				}
				if ($flag==0)
				{
					$ps[$p]=substr($item,1);
					$pc[$p]=1;
					$p++;
				}
				if ($flag==1) 
				{
					$pc[$kp]+=1;
				}
			}
		}
		if ("F" eq substr($item,1,1)) 
		{
			if ($f==0) 
			{
				$fs[$f]=substr($item,1);
				$fc[$f]=1;
				$f++;
			}
			else
			{
				$flag=0;
				$kf=0;
				foreach $fline (@fs)
				{
					if ($fs[$kf] eq substr($item,1))
					{
						$flag=1;
						last;				
					}
					$kf++;
				}
				if ($flag==0)
				{
					$fs[$f]=substr($item,1);
					$fc[$f]=1;
					$f++;
				}
				if ($flag==1) 
				{
					$fc[$kf]+=1;
				}
			}
		}
		if ("C" eq substr($item,1,1)) 
		{
			if ($c==0) 
			{
				$cs[$c]=substr($item,1);
				$cc[$c]=1;
				$c++;
			}
			else
			{
				$flag=0;
				$kc=0;
				foreach $cline (@cs)
				{
					if ($cs[$kc] eq substr($item,1))
					{
						$flag=1;
						last;				
					}
					$kc++;
				}
				if ($flag==0)
				{
					$cs[$c]=substr($item,1);
					$cc[$c]=1;
					$c++;
				}
				if ($flag==1) 
				{
					$cc[$kc]+=1;
				}
			}
		}		
	}
}

$kp=0;
foreach $line (@ps) 
{
	chomp($line);
	$pname=substr($line,2);
	print OUTFILE substr($line,2)."\t";
	$name="";
	foreach $gline (@go) 
	{
		chomp($gline);
		
		if ("name:" eq substr($gline,0,5)) 
		{
			$name=substr($gline,6);
		}
		else
		{
			if ($pname eq $name && "namespace:" eq substr($gline,0,10)) 
			{
				print OUTFILE substr($gline,11)."\t";
			}
			if ($pname eq $name && "def:" eq substr($gline,0,4)) 
			{
				$ss=substr($gline,6);
				$index=index($ss,'"');
				print OUTFILE substr($ss,0,$index)."\t";
				last;
			}
		}
	}
	print OUTFILE $pc[$kp]."\n";
	$kp++;
}
print OUTFILE "\n"."\n";
$kf=0;
foreach $line (@fs) 
{
	chomp($line);
	$fname=substr($line,2);
	print OUTFILE substr($line,2)."\t";
	$name="";
	foreach $gline (@go) 
	{
		chomp($gline);
		
		if ("name:" eq substr($gline,0,5)) 
		{
			$name=substr($gline,6);
		}
		else
		{
			if ($fname eq $name && "namespace:" eq substr($gline,0,10)) 
			{
				print OUTFILE substr($gline,11)."\t";
			}
			if ($fname eq $name && "def:" eq substr($gline,0,4)) 
			{
				$ss=substr($gline,6);
				$index=index($ss,'"');
				print OUTFILE substr($ss,0,$index)."\t";
				last;
			}
		}
	}
	print OUTFILE $fc[$kf]."\n";
	$kf++;
}
print OUTFILE "\n"."\n";
$kc=0;
foreach $line (@cs) 
{
	chomp($line);
	$cname=substr($line,2);
	print OUTFILE substr($line,2)."\t";
	$name="";
	foreach $gline (@go) 
	{
		chomp($gline);
		
		if ("name:" eq substr($gline,0,5)) 
		{
			$name=substr($gline,6);
		}
		else
		{
			if ($cname eq $name && "namespace:" eq substr($gline,0,10)) 
			{
				print OUTFILE substr($gline,11)."\t";
			}
			if ($cname eq $name && "def:" eq substr($gline,0,4)) 
			{
				$ss=substr($gline,6);
				$index=index($ss,'"');
				print OUTFILE substr($ss,0,$index)."\t";
				last;
			}
		}
	}
	print OUTFILE $cc[$kc]."\n";
	$kc++;
}
close OUTFILE;