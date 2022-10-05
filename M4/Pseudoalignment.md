# Alineamiento de lecturas crudas al transcriptoma de referencia  
  
Basado en: https://www.icloud.com/keynote/0UePBv3d_VkYkZSiZ2lqnYclQ#Lecture2%5FreadMapping  
### Kallisto

'conda activate rnaseq'  
   
   Cambiarse al directorio correcto
'cd  /home/alumnoN/rna_a # N es el número de alumno'
  
Indexar la referencia    
'kallisto index -i Homo_sapiens.GRCh38.cdna.all.index /home/rna_avelar/Homo_sapiens.GRCh38.cdna.all.fa.gz'  
  
Correr el pseudoalineamiento  
'kallisto quant -i Homo_sapiens.GRCh38.cdna.all.index –pseudobam -o OutputKallisto -t 4 --single -l 250 -s 30 /home/rna_avelar/fastq/SRR8668755_1M_subsample.fastq.gz'  
 
  
Usar samtools para preparar la visualización en IGV  
  
Generar archivo .sam  
'samtools view -h -o pseudoalignments.sam pseudoalignments.bam'  
Ordenar  
'samtools sort -o pseudoalignments.sorted.bam pseudoalignments.bam'  
Indexar  
'samtools index pseudoalignments.sorted.bam'  
   
  
    
### BWA  
Basado en: https://datacarpentry.org/wrangling-genomics/04-variant_calling/index.html    
  
Indexar la referencia  
'bwa index Homo_sapiens.GRCh38.cdna.all.fa'  
  
Alineamiento:  
'bwa mem Homo_sapiens.GRCh38.cdna.all.fa /home/rna_avelar/fastq/SRR8668755_1M_subsample.fastq.gz > results_bwa.aligned.sam'    
  
Usar samtools para preparar la visualización en IGV  

'samtools view -S -b results_bwa.aligned.sam > results_bwa.aligned.bam'  
'samtools sort -o results_bwa.aligned.sorted.bam results_bwa.aligned.bam'  
'samtools index results_bwa.aligned.sorted.bam'  
  
  
Algunos transcritos interesantes en IGV:    
_ENST00000433297.2_  
_ENST00000433543.2_  
_ENST00000676245.1_  
_ENST00000613167.4_  

