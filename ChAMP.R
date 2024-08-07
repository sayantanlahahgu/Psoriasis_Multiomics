library(ChAMP)
memory.limit(size=70000)
setwd("C:/Users/ACER/Desktop/psoriasis_ChAMP_pwd")
myLoad <- champ.load(directory = getwd(), SampleCutoff=0.11, method="champ", arraytype="450K")  # use method Champ or minfi
source("champ.PairedDMP.R")
source("champ.PairedDMR.R")
myNorm <- champ.norm(beta=myLoad$beta,arraytype="450K",method = "BMIQ",cores=1) 
myCombat <- champ.runCombat(beta=myNorm,pd=myLoad$pd,batchname=c("Batch_ID"))
myPair <- champ.PairedDMP(beta = myCombat, pair = myLoad$pd$individual, pheno = myLoad$pd$Sample_Group, adjPVal = 0.05, adjust.method = "BH", compare.group = c("Normal","Disease"), arraytype = "450K")
write.csv(myPair,"champ_results_MM_negative_common_samples.csv")


Alternate script:
library(ChAMP)
memory.limit(size=70000)
setwd("C:/Users/ACER/Desktop/psoriasis_ChAMP_pwd")
source("champ.PairedDMP.R")
myLoad <- champ.load(directory = getwd(), SampleCutoff=0.11, method="minfi", arraytype="450K")  # use method Champ or minfi
champ.QC(beta = myLoad$beta)
myNorm <- champ.norm(beta=myLoad$beta,arraytype="450K",rgSet=myLoad$rgSet,mset=myLoad$mset,method = "BMIQ",cores=3) 
myCombat <- champ.runCombat(beta=myNorm,pd=myLoad$pd,batchname=c("Batch_ID"))
champ.QC(beta = myCombat,resultsDir="./CHAMP_QCimages_common_after_Norm_and_Combat/")
myPair <- champ.PairedDMP(beta = myCombat, pair = myLoad$pd$individual, pheno = myLoad$pd$Sample_Group, adjPVal = 0.05, adjust.method = "BH", compare.group = c("Normal","Disease"), arraytype = "450K")
write.csv(myCombat,"Beta_values_BMIQ_all_common_samples_using_BatchID.csv")
write.csv(myPair,"DMP_all_common_samples_BatchID.csv")
