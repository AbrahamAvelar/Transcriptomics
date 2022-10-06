# Cargar datos ----
setwd("/home/alumnoX/rna_a/DGE")
getwd()
counts <- read.table("GSE135430_RNA_Isolation_Comparison_TPM.txt", header=TRUE, row.names = 1, sep="\t", comment.char="") 
# Cargar librerias ----
library(edgeR)
library(limma)
# Plot datos crudos ----
pdf(file="TwoSampleCompare.pdf", width=4, height=4)
plot(counts$Phenol_t0_Rep1, counts$RNeasy_t0_Rep1)
dev.off()

# Agrupar muestras ----
grp <- factor(rep(1:6,each=4))
grp <- c("PhenolT0","PhenolT0","PhenolT0","PhenolT0",
        "PhenolT20","PhenolT20","PhenolT20","PhenolT20",
        "RNAeasyT0","RNAeasyT0","RNAeasyT0","RNAeasyT0",
        "RNAeasyT20","RNAeasyT20","RNAeasyT20","RNAeasyT20",
        "TrizolT0","TrizolT0","TrizolT0","TrizolT0",
        "TrizolT20","TrizolT20","TrizolT20","TrizolT20")

# Normalize ----
dge <- DGEList(counts=counts, group=grp)
dge
dgeNorm <- calcNormFactors(dge)
dgeNorm <- estimateCommonDisp(dgeNorm)
dgeNorm

# DGE ----
diff_exp <- exactTest(dgeNorm, dispersion=dgeNorm$common.dispersion, pair =c("1","2") )
deTab = topTags(diff_exp, n=Inf)$table
deTab
# Plots DGE ----
deGenes <- rownames(deTab)[deTab$FDR<.05 & abs(deTab$logFC)>2]


pdf(file="DGE_1vs2.pdf", width=4, height=4)
plotSmear(dge, de.tags=deGenes, ylab="1(PhenolT0)vs2(PhenolT20)")
dev.off()

deGenesDecide <- decideTestsDGE(diff_exp, adjust.method = "BH",p.value=.05)
deGenesDecide
deltags1<-rownames(deGenesDecide)[as.logical(deGenesDecide)]
pdf(file="DGE_Decide_1vs2.pdf", width=4, height=4)
plotSmear(dge, de.tags=deltags1, ylab="1(PhenolT0)vs2(PhenolT20)")
