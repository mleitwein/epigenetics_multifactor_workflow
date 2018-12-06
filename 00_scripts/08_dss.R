############################ DSS for WGBS #########################################
###################################################################################

ls()
rm(list=ls())
ls()

# Installing packages

#source("https://bioconductor.org/biocLite.R")
#biocLite("DSS")

# Load library
library(DSS)

#set working directory
setwd("XXX")
	
#Load data ####
	PATH="05_results"

	file_list= list.files(path=PATH, pattern=paste0("F_*[0-9]*.dss"))
	list.df= lapply(paste0(PATH,"/",file_list), function(x) read.table(x, header=T))
  

 #Build DSS object ####
BSobj <- makeBSseqData(list.df,
                        file_list)
                       
# save R image to reload next time (BSobj is really big)	
	save.image() 
	 
#Make design ####
info<-read.table("info_samples.txt", header=T)
design<-info[,3:5]


# Build model ####

DMLfit = DMLfit.multiFactor(BSobj, 
                            design=design, 
                            formula=~origine+sexe+pisciculture+origine:sexe+origine:pisciculture)
DMLfit$X
save(DMLfit,file="06_statistics/dmlfit.dss.rda")

### Function DML and DMR depending of factors 

call_dml_dmr<-function (factor, coef){

  # Testing
  #smooth model ?
  DML.test = DMLtest.multiFactor(DMLfit, coef= coef)
  
  #save model
  filename <- paste0("06_statistics/dml.",factor, ".txt")
  write.table(DML.test, filename, quote = FALSE, col.names=TRUE,row.names=FALSE, sep="\t")
  save(DML.test,file=paste0("06_statistics/dml.",factor, ".rda"))
  
    resOrdered = DML.test[order(DML.test$pvals),]
    resSig.p = subset(resOrdered, pvals<0.001)
    dim(resSig.p)
    resSig.fdr = subset(resOrdered, fdrs<0.1)
    dim(resSig.fdr)
  
  #DMR   
  DMR.test <- callDMR(DML.test, 
                      p.threshold=0.01, #0.001
                      minlen = 100, 
                      minCG = 10, 
                      dis.merge = 50, 
                      pct.sig = 0.4)
    dim(DMR.test)
    #save
    
    write.table(DMR.test,file=paste0("06_statistics/dmr.",factor, ".txt"),quote=F)
    save(DMR.test,file=paste0("06_statistics/dmr.",factor, ".rda"))

    
  #Plot tests stats ####
    par(mfrow=c(1,2))
    hist(DML.test$stat, 50, main=paste0("test statistics ", factor), xlab="")
    hist(DML.test$pvals, 50, main=paste0("P values", factor), xlab="")
  
  #Plot DMR ####
    head(DMR.test)
    showOneDMR(DMR.test[1,], BSobj)
}
    
### Origine : Hatchery Vs Wild

call_dml_dmr("origine", 2)   
    
### Sexe : M Vs F #####################
call_dml_dmr("sexe", 3)

### Pisciculture : conuma Vs Quisnam #####################
call_dml_dmr("pisciculture", 4)

### interaction : origine: sexe #####################
call_dml_dmr("interactio_origine_sexe", 5)

### interaction : origine: pisciculture #####################
call_dml_dmr("interactio_origine_pisci", 6)
