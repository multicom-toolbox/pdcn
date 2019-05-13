#!/usr/bin/perl -w
$GLOBAL_PATH='/storage/htc/bdm/jh7x3/PDCN_github/pdcn/';

$numArgs = @ARGV;
if($numArgs != 2)
{   
	print "the number of parameters is not correct!";
	exit(1);
}

$seq = "$ARGV[0]";
$outdir = "$ARGV[1]";

`mkdir -p $outdir/sequence $outdir/Blast_output $outdir/Prediction_output`;

print "(1) Running blast\n\n";
`perl scripts/exe_swiss.pl $seq $outdir/sequence $outdir/Blast_output`;

print "(2) Getting prediction\n\n";

`perl scripts/get_swiss.pl $seq  $outdir/Prediction_output/function.txt $outdir/Blast_output`;
`perl scripts/get_function.pl $outdir/Prediction_output/function.txt $GLOBAL_PATH/database/go-basic.obo $outdir/Prediction_output/functionnew.txt`;

`cp $outdir/Prediction_output/function.txt $outdir/PDCN_function.txt`;
`cp $outdir/Prediction_output/functionnew.txt $outdir/PDCN_function_annotation.txt`;

print "The predicted functions are saved in $outdir/PDCN_function.txt\n";
print "The function annotations are saved in $outdir/PDCN_function_annotation.txt\n";