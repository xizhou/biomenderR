# biomenderR

## Installation
```r
install.packages("devtools")
devtools::install_github("xizhou/biomenderR")
```

## Usage
### A quick start:
```r
x <- c("In this paper, we proposed biomenderR, an R-based biomedical journal \
recommendation framework using abstract text embedding approach. biomenderR \
runs in user-friendly R environment and is convenient in application \
without deep learning knowledge.The core model was trained based on \
a large dataset containing 6,240,122 abstract texts from 1352 journals \
extracted from the PubMed database. Our framework is lightweight costing \
about 100 MB of hard-disk space while maintaining equivalent performance \
to state-of-the-art methods. Moreover, we innovatively applied this framework \
to provide an in-depth analysis on the characteristics and associations of \
research fields covered by more than 1000 biomedical journals worldwide.")

y <- biomender(x,k=10)
y

     [,1]                                               
[1,] "IEEE-journal-of-biomedical-and-health-informatics"
     [,2]                                          
[1,] "Computer-methods-and-programs-in-biomedicine"
     [,3]                         [,4]                               
[1,] "Journal-of-medical-systems" "Journal-of-biomedical-informatics"
     [,5]                               
[1,] "Computers-in-biology-and-medicine"
     [,6]                                          
[1,] "Medical-&-biological-engineering-&-computing"
     [,7]                                                               
[1,] "IEEE/ACM-transactions-on-computational-biology-and-bioinformatics"
     [,8]                 [,9]                                          
[1,] "BMC-bioinformatics" "IEEE-transactions-on-bio-medical-engineering"
     [,10]  
```
