library(wordcloud)

data1 <- as.character(read.table("../TABLE.txt", sep="|")[,3])

png("tagcloud_symbol.png", width=400,height=400)
wordcloud(data1, min.freq=1)
dev.off()

jpeg("tagcloud_symbol.jpeg", width=400,height=400)
wordcloud(data1, min.freq=1)
dev.off()

postscript(
  file="./tagcloud_symbol.eps", width = 4, height = 4,
  horizontal = FALSE, onefile = FALSE, paper = "special",
  family="Times"
)
wordcloud(data1, min.freq=1)
dev.off()


# data2 <- as.character(read.table("../TABLE.txt", sep="|")[,2])
# data2 <- gsub(" ", "", data2)

# png("tagcloud_org.png", width=400,height=400)
# wordcloud(data2, min.freq=1)
# dev.off()

# jpeg("tagcloud_org.jpeg", width=400,height=400)
# wordcloud(data2, min.freq=1)
# dev.off()

# postscript(
#   file="./tagcloud_org.eps", width = 4, height = 4,
#   horizontal = FALSE, onefile = FALSE, paper = "special",
#   family="Times"
# )
# wordcloud(data2, min.freq=1)
# dev.off()
