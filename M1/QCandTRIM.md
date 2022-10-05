# Control de calidad y trimming de lecturas crudas  

Basado en:  https://datacarpentry.org/wrangling-genomics/02-quality-control/index.html
Datos descargados de: https://diytranscriptomics.com/

### Usar la terminal de bash en RStudio, no la consola de R


Activar el ambiente de conda con el software instalado

`conda activate rnaseq`
  
Mostrar la ayuda de fastqc
`fastqc -h`

Correr el control de calidad con fastqc para una muestra, se puede pasar el archivo comprimido
`fastqc SRR8668758.fastq.gz`
  
  
Verificar que trimmomatic está instalado
`trimmomatic -h`
  
Limpiar las lecturas crudas con trimmomatic
`trimmomatic SE -threads 4 SRR8668759.fastq.gz  SRR8668759.trimmed.fastq.gz SLIDINGWINDOW:4:20`
  
Volver a correr el control de calidad para verificar que trimmomatic limpio las lecturas
`fastqc SRR8668759.trimmed.fastq.gz`

Como aún tiene secuencias repetidas identificadas como adaptadores, hay que volver a correr trimmomatic, pero ahora indicarle que quite los adaptadores de Illumina

Copiar los adaptadores para que trimmomatic los tome en cuenta 
`cp /opt/anaconda3/envs/rnaseq/share/trimmomatic-0.39-2/adapters*SE* ` 

Correr trimmomatic on `ILLUMINACLIP`
`trimmomatic SE -threads 4 SRR8668759.fastq.gz SRR8668759.trimmed.TS2.fastq SLIDINGWINDOW:4:20 ILLUMINACLIP:TruSeq2-SE.fa:2:40:15`

Verificar que las lecturas ya no tienen fragmentos de los adaptadores de Illumina
`fastqc SRR8668759.trimmed.TS2.fastq`




