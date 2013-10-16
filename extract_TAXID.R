data <- read.delim("TAXID_GENESYMBOL.txt", skip=1, header=F, sep="\t", stringsAsFactors = F)
data <- data[which(data[,2] !="NEWENTRY"), ]

write.table(data, file="TAXID_GENESYMBOL.txt")

out <- unique(data[,1])

write.table(out,file="TAXID.txt", row.names=F, col.names=F, quote=F)
