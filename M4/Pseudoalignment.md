# Alineamiento de lecturas crudas al transcriptoma de referencia  
  
### Setup
  
Cambiarse al directorio transcriptomics
'cd ~/transcriptomics'  
  
  
Asegurarse que están activo el ambiente de conda y que está instalado kallisto
'conda activate rnaseq'  
'kallisto -h'  
  
Descargar transcriptoma de referencia del sitio web del embl https://ftp.ensembl.org/pub/release-109/fasta/homo_sapiens
  
  
### Kallisto  
  
Indexar la referencia (aprox 6 minutos)   
'kallisto index -ii omo_sapiens.GRCh38.cdna.all.index Homo_sapiens.GRCh38.cdna.all.fa.gz'  
  
Correr el pseudoalineamiento 6:57
'kallisto quant -i Homo_sapiens.GRCh38.cdna.all.index –pseudobam -o OutputKallisto -t 4 --single -l 250 -s 30 SRR8668755_1M_subsample.fastq.gz'  
 
### Samtools
Usar samtools para preparar la visualización en IGV  
  
Generar archivo .sam  
'samtools view -h -o pseudoalignments.sam pseudoalignments.bam'  
Ordenar  
'samtools sort -o pseudoalignments.sorted.bam pseudoalignments.bam'  
Indexar  
'samtools index pseudoalignments.sorted.bam'  
   
  
    
### BWA  
  
Indexar la referencia  
'bwa index Homo_sapiens.GRCh38.cdna.all.fa'  
  
Alineamiento:  
'bwa mem Homo_sapiens.GRCh38.cdna.all.fa SRR8668755_1M_subsample.fastq.gz > results_bwa.aligned.sam'    
  
Usar samtools para preparar la visualización en IGV  

'samtools view -S -b results_bwa.aligned.sam > results_bwa.aligned.bam'  
'samtools sort -o results_bwa.aligned.sorted.bam results_bwa.aligned.bam'  
'samtools index results_bwa.aligned.sorted.bam'  
  
  
Algunos transcritos interesantes en IGV:    
_ENST00000433297.2_  
_ENST00000433543.2_  
_ENST00000676245.1_  
_ENST00000613167.4_  
_ENST00000414273.1_  


Basado en: 
https://www.icloud.com/keynote/0UePBv3d_VkYkZSiZ2lqnYclQ#Lecture2%5FreadMapping  
https://datacarpentry.org/wrangling-genomics/04-variant_calling/index.html   
