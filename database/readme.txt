Download databases

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
