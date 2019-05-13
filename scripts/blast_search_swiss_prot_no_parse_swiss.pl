#!/bin/perl -w
###########################################################
#used to run psi-blast on swiss prot and parse the results.
#Input:
#Ouput:
#
#Author: ZHENG WANG, June 10th, 2008.
###########################################################

use strict;
if(@ARGV != 8){
	die "Need 6 parameters: the path and file name of the sequence file containing all query sequences, the path of the psiblast executable program, the path of the directory where the single sequences are stored, the output folder path where the psiblast results are stored, the path of the database fasta file, the .dat database file for swissprot, and the LOG file path, and the original fasta file for the database;";
}
my $seq_file_all = $ARGV[0];
my $psi_blast_exe = $ARGV[1];
my $query_seq_dir = $ARGV[2]; #where to save the sequence files for query;
my $output_dir = $ARGV[3]; #where to save the psiblast results;
my $db_blast_dir = $ARGV[4];
my $db_content_dir = $ARGV[5];
my $log_file = $ARGV[6];
my $db_fasta_file = $ARGV[7]; 


#######(1) Read the overal sequence file and seperate it into many single sequence files########### 
open(SEQALL, "<$seq_file_all");
open(LOG, ">$log_file");

##############Read db into array#######
#print LOG "Reading the database into memory...\n";
#open(DB, "<$db_content_dir");
#my @db = <DB>;
#close(DB);
######################################
my $id;
my $seq;
my $first_seq = "true";
while(<SEQALL>){
	my $line = $_;
	$line =~ s/\n//;
	if(length($line) <= 0){
		next;
	}
	if($line =~ />/){
		if($first_seq eq "false"){
			my $single_seq_path = $query_seq_dir."/".$id.".fasta";
			open(WRITE, ">$single_seq_path");
			print WRITE ">$id\n$seq\n";
			close(WRITE);
			print LOG "$id\n";
			$seq = "";

			############run psiblast on the query single sequence on the database##########
			my $psi_blast_command = "$psi_blast_exe -i $single_seq_path -d $db_blast_dir -j 3 >$output_dir"."/"."$id".".out";	
			print $psi_blast_command."\n";
			print LOG "PSI-BLAST ".$psi_blast_command."\n";
			`$psi_blast_command`;
			
		}
		if($first_seq eq "true"){
			$first_seq = "false";
		}
		$id = substr($line, 1, 6);

	}
	else{
		$seq = $seq.$line;
		$seq =~ s/\n//;
	}
}
close(SEQALL);
close(LOG);
#######OVER (1)#############

