# pdcn
protein function prediction using protein domain co-occurrence network (pdcn - ranked as one of the best methods in CAFA1 competition


Test Environment
--------------------------------------------------------------------------------------
Red Hat Enterprise Linux Server release 6.4 (Santiago)

Installation Steps
--------------------------------------------------------------------------------------


**(A) Download and Unzip profun source package**  

Create a working directory called 'pdcn' where all scripts, programs and databases will reside:

Download the pdcn code:
```
cd ~/
git clone https://github.com/multicom-toolbox/pdcn.git
cd pdcn
```

**(B) Download programs**
```
cd programs
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/legacy.NOTSUPPORTED/2.2.26/blast-2.2.26-x64-linux.tar.gz
tar -zxvf blast-2.2.26-x64-linux.tar.gz

```

**(C) Download database**

```
mkdir database
cd database
mkdir swiss_prot
cd swiss_prot
wget ftp://ftp.uniprot.org/pub/databases/uniprot/knowledgebase/uniprot_sprot.fasta.gz
wget ftp://ftp.uniprot.org/pub/databases/uniprot/knowledgebase/uniprot_sprot.dat.gz
gzip -d uniprot_sprot.dat.gz
gzip -d uniprot_sprot.fasta.gz

../../programs/blast-2.2.26/bin/formatdb  -p T -i uniprot_sprot.fasta


wget http://purl.obolibrary.org/obo/go/go-basic.obo

```

**(D) Test**
cd scripts
mkdir -p ./test/2SN3-A/sequence ./test/2SN3-A/Blast_output

(1) Run blast
perl exe_swiss.pl ./test/2SN3-A.fasta ./test/2SN3-A/sequence ./test/2SN3-A/Blast_output
perl get_swiss.pl ./test/2SN3-A.fasta ./test/2SN3-A/2SN3-A_function.txt ./test/2SN3-A/Blast_output

(2) Run prediction
perl get_function.pl ./test/2SN3-A/2SN3-A_function.txt ./database/go-basic.obo ./test/2SN3-A/2SN3-A_functionnew.txt
perl getGeneforFunction.pl ./test/2SN3-A/2SN3-A_functionnew.txt ./test/2SN3-A/2SN3-A_function.txt ./test/2SN3-A/2SN3-A_functionnewnew.txt

```

