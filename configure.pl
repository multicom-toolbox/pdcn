#!/usr/bin/perl -w
use Cwd;
use Cwd 'abs_path';

################Don't Change the code below##############
$install_dir = getcwd;
$install_dir=abs_path($install_dir);

if (! -d $install_dir)
{
	die "can't find installation directory.\n";
}
if ( substr($install_dir, length($install_dir) - 1, 1) ne "/" )
{
	$install_dir .= "/"; 
}


if (prompt_yn("PDCN will be installed into <$install_dir> ")){

}else{
	die "The installation is cancelled!\n";
}
print "Start install PDCN into <$install_dir>\n\n";


$files		="scripts/exe_swiss.pl,scripts/blast_search_swiss_prot.pl,run_pdcn.pl";

@updatelist		=split(/,/,$files);

foreach my $file (@updatelist) {
	$file2update=$install_dir.$file;
	
	$check_log ='$GLOBAL_PATH=';
	open(IN,$file2update) || die "Failed to open file $file2update\n";
	open(OUT,">$file2update.tmp") || die "Failed to open file $file2update.tmp\n";
	while(<IN>)
	{
		$line = $_;
		chomp $line;

		if(index($line,$check_log)>=0)
		{
			print "### Setting ".$file2update."\n";
			print "\t--- Current ".$line."\n";
			print "\t--- Change to ".substr($line,0,index($line, '=')+1)." \'".$install_dir."\';\n\n\n";
			print OUT substr($line,0,index($line, '=')+1)."\'".$install_dir."\';\n";
		}else{
			print OUT $line."\n";
		}
	}
	close IN;
	close OUT;
	system("mv $file2update.tmp $file2update");
	system("chmod 755  $file2update");


}

print "\n!!! Installation finished!\n";

sub prompt_yn {
  my ($query) = @_;
  my $answer = prompt("$query (Y/N): ");
  return lc($answer) eq 'y';
}
sub prompt {
  my ($query) = @_; # take a prompt string as argument
  local $| = 1; # activate autoflush to immediately show the prompt
  print $query;
  chomp(my $answer = <STDIN>);
  return $answer;
}