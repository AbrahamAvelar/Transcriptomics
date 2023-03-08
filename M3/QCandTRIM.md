# Setup  
 
### Usar la terminal de bash en RStudio, no la consola de R  

En la pestaña _Terminal_ Ubicarse en la carpeta home  
`cd ~`  
Para asegurarse que están en el directorio correcto `pwd` debe mostrar como output `/home/alumnoX`.  
  
  
Crear directorio de trabajo  
`mkdir  transcriptomica`  
  
cambiarse al directorio 'transcriptomica'
`cd transcriptomica`
  
  
Descargar datos 
`wget "https://www.dropbox.com/s/8de6xkvv9gwhfy5/SRR8668755_1M_subsample.fastq.gz"`
  
  
# Visualizar datos crudos  
  
Descomprimir archivos
`gunzip SRR8668755_1M_subsample.fastq.gz`  
Ver las primeras 20 líneas
`head SRR8668755_1M_subsample.fastq -n20` 

# Control de calidad y trimming de lecturas crudas    
  

Activar el ambiente de conda con el software instalado  
  
`conda activate rnaseq`  
    
Mostrar la ayuda de fastqc   
`fastqc -h`  
  
Correr el control de calidad con fastqc para una muestra, se puede pasar el archivo comprimido  
`fastqc SRR8668755_1M_subsample.fastq.gz`  
    
    
Verificar que trimmomatic está instalado    
`trimmomatic -h`  
    
Limpiar las lecturas crudas con trimmomatic  
`trimmomatic SE -threads 4 SRR8668755_1M_subsample.fastq.gz SRR8668755_1M_subsample.trimmed.fastq.gz SLIDINGWINDOW:4:20`

Volver a correr el control de calidad para verificar que trimmomatic limpio las lecturas  
`fastqc SRR8668755_1M_subsample.trimmed.fastq.gz`  
  
Si tuviera secuencias repetidas identificadas como adaptadores, hay que volver a correr trimmomatic, pero ahora indicarle que quite los adaptadores de Illumina    
Copiar los adaptadores para que trimmomatic los tome en cuenta   
`cp /opt/old_files/Trimmomatic-0.38/adapters/*SE* `   
  
Correr trimmomatic on `ILLUMINACLIP`  
`trimmomatic SE -threads 4 SRR8668755_1M_subsample.fastq.gz SRR8668755_1M_subsample.trimmed.fastq.TS2.gz SLIDINGWINDOW:4:20 ILLUMINACLIP:TruSeq2-SE.fa:2:40:15`  
  
Verificar qué cambió   
`fastqc SRR8668755_1M_subsample.trimmed.fastq.TS2.gz`  

  
### Ejercicio:  
_Limpiar y verificar la calidad de todos los datos crudos [://diytranscriptomics.com/data]_
  
Basado en:  https://datacarpentry.org/wrangling-genomics/02-quality-control/index.html  
Datos descargados de: https://diytranscriptomics.com/data 


