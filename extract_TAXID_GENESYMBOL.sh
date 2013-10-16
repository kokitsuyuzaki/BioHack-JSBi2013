#! /bin/sh

# データは以下のFTPサイトより
# ftp://ftp.ncbi.nih.gov/gene//DATA/gene_info.gz

cut -f1,3 gene_info > TAXID_GENESYMBOL.txt