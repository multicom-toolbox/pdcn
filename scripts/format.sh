#/bin/sh
########################################
#used to format the fasta database 
#to BLAST needed format.
#
#Author: Zheng Wang, June 10th, 2008.
########################################

#/home/zwang/data/blast-2.2.9/formatdb -i /home/zwang/data/pfam/Pfam-A.fasta -n /home/zwang/data/soybean_function/data/pfam/Pfam-A.fasta

#/home/zwang/data/blast-2.2.9/formatdb -i /home/zwang/data/swiss_prot/uniprot_sprot.fasta -n /home/zwang/data/soybean_function/data/swiss_prot/uniprot_sprot.fasta

/home/zwang/data/blast-2.2.9/formatdb -i /home/zwang/data/swiss_prot_2010/uniprot_sprot.fasta -n /home/zwang/data/swiss_prot_2010/uniprot_sprot.fasta

