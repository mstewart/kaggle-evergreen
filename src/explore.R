df <- read.table(file.choose(), sep="\t", header=TRUE )

names(df)
hist(df$avglinksize)

hist(df$label)
n.words <- factor(df$numwords_in_url)
levels(n.words)
library(rpart);
df.Tree <- df[,c( -2 ,-3, -4)]

df.Tree$url
domains <- strsplit(as.character(df.Tree$url), "://", fixed=TRUE)
domains <- lapply(domains , function(x){
  url <- unlist(x[2])
  domain <- strsplit(url , "/" , fixed=TRUE)
  domain <- unlist(domain[[1]])
  return(domain[[1]])
  })

selection <- which(df.Tree$alchemy_category_score == "?")
df.Tree$alchemy_category_score = as.numeric(as.character(df.Tree$alchemy_category_score))
df.Tree$alchemy_category_score[selection] <- 0.0 
classifier.tree <-rpart(label ~ . , data=df.Tree,  method="class", control=rpart.control(minsplit=1));
plot(classifier.tree)
text(classifier.tree, use.n=TRUE)
sort(df$alchemy_category_score)

