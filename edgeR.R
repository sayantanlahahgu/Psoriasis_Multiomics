raw_counts <- read.table(file.choose(),header = TRUE, sep = "\t") 
head(raw_counts)
group <- factor(c("71","71","79","79","85","85","87","87","90","90","91","91","97","97","98","98","99","99","100","100","101","101","108","108","56","56","43","43","62","62","134","134","135","135","58","58","67","67","59","59","48","48","159","159","127","127","76","76")) 
group
condition <- c("N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D","N","D")
condition
y <- DGEList(counts = raw_counts[,4:51], genes = raw_counts[,1:3],group = group, remove.zeros = TRUE)
dim(y)
y_norm <- calcNormFactors(y)
y_norm
df <- data.frame(Sample = colnames(y_norm),group,condition)
df
design <- model.matrix(~group + condition)
design
rownames(design) = colnames(y_norm)
design
y_norm <- estimateDisp(y_norm,design,robust=TRUE)
y_norm$common.dispersion
fit <- glmQLFit(y_norm, design)
lrt <- glmQLFTest(fit)
result <- topTags(lrt, n=42498, adjust.method="BH", sort.by="none", p.value=1)
write.csv(result,"C:/Users/ACER/Desktop/Psoriasis_total_set.csv")

