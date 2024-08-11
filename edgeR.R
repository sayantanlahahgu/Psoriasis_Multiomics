# Install edgeR in R from https://bioconductor.org/packages/release/bioc/html/edgeR.html

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("edgeR")

library (edgeR)

# Read raw read counts 
# column 1 contains gene symbols, columns 2-49 are the raw counts for each sample
raw_counts <- read.table(file.choose(),header = TRUE, sep = "\t") 

# Define groups based on paired sample data
group <- factor(c("71","71","79","79","85","85","87","87","90","90","91","91","97","97","98","98","99","99","100","100","101","101","108","108","56","56","43","43","62","62","134","134","135","135","58","58","67","67","59","59","48","48","159","159","127","127","76","76")) 

# Define condition as normal or diseased
condition <- c("N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D")

# Create DEGList object
y <- DGEList(counts = raw_counts[,2:49], genes = raw_counts[,1],group = group, remove.zeros = TRUE)

# Library normalization
y_norm <- calcNormFactors(y)

# Create design matrix for fitting generalized linear model
design <- model.matrix(~group + condition)
rownames(design) = colnames(y_norm)

# Estimate dispersion
y_norm <- estimateDisp(y_norm,design,robust=TRUE)
y_norm$common.dispersion

# Fit model
fit <- glmQLFit(y_norm, design)

# Perform DGE test
lrt <- glmQLFTest(fit)

# Adjust raw p-values and extract data 
result <- topTags(lrt, n=dim(y_norm), adjust.method="BH", sort.by="none", p.value=1)

# Write output to file
write.csv(result,"DGE_results.csv")

