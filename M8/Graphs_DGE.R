# Basado en: https://www.linkedin.com/mwlite/in/jose-manuel-villalobos-escobedo-b49948213

# plotSmear ----
deGenes <- rownames(deTab)[deTab$FDR<.05 & abs(deTab$logFC)>2]
pdf(file="DGE_1vs2.pdf", width=4, height=4)
plotSmear(dge, de.tags=deGenes, ylab="1(PhenolT0)vs2(PhenolT20)")
dev.off()

deGenesDecide <- decideTestsDGE(diff_exp, adjust.method = "BH",p.value=.01)
deGenesDecide
deltags1<-rownames(deGenesDecide)[as.logical(deGenesDecide)]
pdf(file="DGE_Decide_1vs2.pdf", width=4, height=4)
plotSmear(dge, de.tags=deltags1, ylab="1(PhenolT0)vs2(PhenolT20)")
dev.off()


# heatmap ----
library("gplots")
library("RColorBrewer")
normalizados= cpm(counts)
normalizados_diferenciales= normalizados[deGenes,]
head(normalizados_diferenciales)
pdf(file="Heatmap.pdf", width=4, height=4)
heatmap(normalizados_diferenciales[,1:8])
dev.off()


h = heatmap(normalizados_diferenciales[,1:8], keep.dendro=TRUE)
pdf(file="Norm_Diff_Plot.pdf", width=4, height=4)
plot(dgeNorm$counts[h$rowInd,1:8])
dev.off()
row.clusters = as.hclust(h$Rowv)
cutree(row.clusters, k=3)  # break into k=3 clusters


# plotmds y pca ----
pdf(file="MDS.pdf", width=4, height=4)
plotMDS(dge)
dev.off()

pdf(file="MDS.pdf", width=4, height=4)


pca <- princomp(normalizados_diferenciales[,c(1:8)])
pdf(file="PCA.pdf", width=4, height=4)
plot(pca$loadings, col=as.factor(colnames(normalizados_diferenciales[,c(1:8)])),  pch=19, cex=2, main="Phenol T0vsT20")
text(pca$loadings, as.vector(colnames(normalizados_diferenciales[,c(1:8)])), pos=3, cex=0.8)
dev.off()

pca <- princomp(normalizados_diferenciales)
pdf(file="PCA-1.pdf", width=4, height=4)
plot(pca$loadings, col=as.factor(as.factor(grp)),  pch=19, cex=.2, main="Phenol T0vsT20")
text(pca$loadings, as.vector(grp), pos=3, cex=0.8)
dev.off()

# Volcano plot ----
pdf(file="VolcanoPlot.pdf", width=4, height=4)
with(deTab, plot(logFC, -log10(FDR), pch=20, cex=0.8, col="black", main="phenol T0v - T20", xlim=c(-8, 8), ylim=c(0,300)))
text(deTab[1:20,]$logFC,-log(deTab[1:20,]$FDR,10),labels=rownames(deTab[1:20,]),cex=1.2,pos=1)
with(subset(deTab, FDR<.01 & abs(logFC)>2), points(logFC, -log10(FDR), pch=20, cex=0.5, col="red"))
abline(v=2,lty=2, col="blue")
abline(v=-2,lty=2, col="blue")
legend("bottomright","Up",cex=0.2)
legend("bottomleft","Down",cex=0.2)
dev.off()


# Cuentas de genes interesantes con ggplot ----
library(reshape2)
# install.packages("cli") # solo correr una vez
# install.packages("tidyverse") # solo correr una vez
library(tidyverse)
library(ggplot2)
# interestingGenes <-as.data.frame(log2(dgeNorm$counts[deGenes[1:10],1:8])) # para ver los 10 más DEG
# interestingGenes <- c("YBR117C","YKL216W") # algunos genes específicos sobre y sub expresados
interestingGenes <- rownames(tail(head(deTab, 100), 10)) # para ver 10 genes que sean interesantes

dfcounts<-as.data.frame(log2(dgeNorm$counts[interestingGenes,1:8]))
counts_tibble<-as_tibble(dfcounts, rownames = "geneID")
pivot_counts<-pivot_longer(counts_tibble, # dataframe to be pivoted
             cols = Phenol_t0_Rep1:Phenol_t20_Rep4 , # column names to be stored as a SINGLE variable
             names_to = "samples", # name of that new variable (column)
             values_to = "expression")

pdf(file="cuentas_Interesantes.pdf", width=4, height=4)
ggplot(pivot_counts, aes(x = samples, y = expression)) + geom_line(aes(color = geneID, group = geneID))
dev.off()

