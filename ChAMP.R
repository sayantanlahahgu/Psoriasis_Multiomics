# Install edgeR in R from https://www.bioconductor.org/packages/release/bioc/html/ChAMP.html

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ChAMP")

library(ChAMP)
# Set current working directory to the directory containing the .idat files and the sample sheet
setwd("Directory_name")

# Pre-filtering of probes
myLoad <- champ.load(directory = getwd(), SampleCutoff=0.11, method="champ", arraytype="450K")  

# Run QC in GUI
champ.QC(beta = myLoad$beta)

# BMIQ normalization
myNorm <- champ.norm(beta=myLoad$beta,arraytype="450K",method = "BMIQ",cores=1) 

# Generate SVD plot
champ.SVD(beta=myNorm,pd=myLoad$pd)

# Batch effect correction using Combat
myCombat <- champ.runCombat(beta=myNorm,pd=myLoad$pd,batchname=c("Batch_ID"))

# Differential methylation analysis
myPair <- champ.PairedDMP(beta = myCombat, pair = myLoad$pd$individual, pheno = myLoad$pd$Sample_Group, adjPVal = 0.05, adjust.method = "BH", compare.group = c("Normal","Disease"), arraytype = "450K")

# Write output to file
write.csv(myPair,"ChAMP_output.csv")
