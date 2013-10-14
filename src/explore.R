# Explore the various data sets available
#
library(rpart);
source("src/exploreFunctions.R")
df.labeled <- read.table("data/train-ag.tsv", sep="\t", header=TRUE )

names(df.labeled)
summary(df.labeled)
hist(df.labeled[, 'avglinksize'])

hist(df.labeled[,'label'])
table(df.labeled$label)

n.words <- factor(df.labeled[,'numwords_in_url'])
levels(n.words)

## Data set for Decision Tree Analysis
df.Tree <- df.labeled[,c( -1,-2 ,-3, -4)]


### Get the domains out of the url
domains <- strsplit(as.character(df.labeled[,'url']), "://", fixed=TRUE)

domains <- lapply(domains , function(x){
  url <- unlist(x[2])
  domain <- strsplit(url , "/" , fixed=TRUE)
  print(length(domain[[1]]))
  domain <- unlist(domain[[1]]) 
  return(domain[[1]])
  })

df.Tree[,'domain'] <- unlist(domains)
df.Tree[,'alchemy_category_score'] <- questionmarkToValue(df.Tree[,'alchemy_category_score'], '?')

## Use classifier tree
classifier.tree <-rpart(label ~ . , data=df.Tree,  method="class", control=rpart.control(minsplit=1));
plot(classifier.tree)
text(classifier.tree, use.n=TRUE)

