data1 <- read.table("TAXID_GENESYMBOL.txt")
data2 <- read.delim("TAXID_TAXNAME.txt", header=F, sep="\t")

month <- c(
"JANUARY", "JANUAR", "JANUA", "JANU", "JAN",
"FEBRUARY", "FEBRUAR", "FEBRUA", "FEBRU", "FEBR", "FEB",
"MARCH", "MARC", "MAR",
"APRIL", "APRI", "APR",
"MAY",
"JUNE", "JUN",
"JULY", "JUL", 
"AUGUST", "AUGUS", "AUGU", "AUG",
"SEPTEMBER", "SEPTEMBE", "SEPTEMB", "SEPTEM", "SEPTE", "SEPT", "SEP",
"OCTOBER", "OCTOBE", "OCTOB", "OCTO", "OCT",
"NOVEMBER", "NOVEMBE", "NOVEMB", "NOVEM", "NOVE", "NOV",
"DECEMBER", "DECEMBE", "DECEMB", "DECEM", "DECE", "DEC"
)

number <- 1:100

dictionary <- c()
for(i in 1:length(month)){
	for(j in 1:length(number)){
		dictionary <- c(dictionary, paste0(month[i], number[j]))
	}
}

write.table(dictionary, "Dictionary.txt", row.names=F, col.names=F, quote=F)

sapply_pb <- function(X, FUN, ...)
{
  env <- environment()
  pb_Total <- length(X)
  counter <- 0
  pb <- txtProgressBar(min = 0, max = pb_Total, style = 3)

  wrapper <- function(...){
    curVal <- get("counter", envir = env)
    assign("counter", curVal +1 ,envir=env)
    setTxtProgressBar(get("pb", envir=env), curVal +1)
    FUN(...)
  }
  res <- sapply(X, wrapper, ...)
  close(pb)
  res
}

Hit <- sapply_pb(dictionary,
	    function(x, y){
	    	return(which(x == y))
	    	# return(grep(x, y))
	    }
	    ,y = data1[,2]
	   )

loc <- c()
for(i in 1:length(Hit)){
	if(length(Hit[[i]]) != 0){
		loc <- c(loc, i)
	}
}

Hit.Symbol <- sapply(loc, function(x){
			    return(Hit[[x]])
		      }
)

names(Hit.Symbol) <- sapply(loc, function(x){
					   return(names(Hit)[x])
	                 }
)

# 48のGENE SYMBOLがヒット
write.table(names(Hit.Symbol), file="Hit.Symbol.txt", quote=F, row.names=F, col.names=F)

# (TAXID - GENESYMBOL) + (TAXID - TAXNAME)
out <- merge(data2, data1[unlist(unique(Hit.Symbol)),], by=1)
write.table(out, "TABLE.txt", quote=F, row.names=F, col.names=F, sep="|")


