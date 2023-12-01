#' @title Predict using the biomedical journal recommendation model  
#'
#' @param x a vector containing abstract text
#' @param k integer with the number of predictions (journals) to make. Defaults to 10
#'
#' @return a matrix in formate m (m abstract text) rows and k (top k suggested journals) columns 
#' @export
#'
#' @examples 
#' \dontrun{
#' library(biomenderR)
#' 
#' x <- "In this paper, we proposed biomenderR, an R-based biomedical journal \
#' recommendation framework using abstract text embedding approach. biomenderR \
#' runs in user-friendly R environment and is convenient in application \
#' without deep learning knowledge.The core model was trained based on \
#' a large dataset containing 6,240,122 abstract texts from 1352 journals \
#' extracted from the PubMed database. Our framework is lightweight costing \
#' about 100 MB of hard-disk space while maintaining equivalent performance \
#' to state-of-the-art methods. Moreover, we innovatively applied this framework \
#' to provide an in-depth analysis on the characteristics and associations of \
#' research fields covered by more than 1000 biomedical journals worldwide."
#' 
#' y <- biomender(x)
#' }
biomender <- function(x,k=10)
{
   .prepare_fun <- function(x,h)
   {
      require(data.table)
      s <- stopwords::stopwords(source="stopwords-iso")
      x <- tolower(x)
      x <- gsub('\\(.*?\\)', '',x)
      x <- strsplit(x,"\\W")
      x <- lapply(x,FUN=function(x) x[!x%in%s])
      x <- lapply(x,FUN=function(x) gsub("^[0-9].*","",x))
      x <- lapply(x,FUN=function(x) x[!x==""])
      x <- lapply(x,textstem::stem_words)
      for(i in seq(x))
      {
         xi <- x[[i]]
         x1i <- xi[-length(xi)]
         x2i <- xi[-1]
         p <- paste(x1i,x2i,sep=" ")
         id <- match(p,h[["x"]])
         p <- h[["ids"]][id]
         p <- p[!is.na(p)]
         x[[i]] <- paste0(c(xi,p),collapse=" ")
      }
      x <- unlist(x)
      x
   }
   
   #temp <- system.file("extdata","biomenderR.ruimtehol",package ="biomenderR")
   #giturl <- "https://raw.github.com/Miao-zhou/biomenderR/main/biomenderR.ruimtehol"
   #download.file(url,temp)
   
   model <- system.file("extdata","biomenderR_compress.ruimtehol",package ="biomenderR")
   h <- readRDS(model)$hash_index
   model <- ruimtehol::starspace_load_model(model)
   x1 <- .prepare_fun(x,h)
   p <- predict(model,x1,k=k)
   p <- lapply(p,function(x) x$prediction$label)
   do.call("rbind",p)   
}
