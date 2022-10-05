# Alineamientos locales con blast  

  
  
  Basado en: https://angus.readthedocs.io/en/2019/running-command-line-blast.html
  
Crear el directorio Myblast y cambiarnos a ese directorio    
`mkdir Myblast  
cd Myblast`
    
  Descargar datos de proteínas de ratón  
`curl -o mouse.1.protein.faa.gz -L https://osf.io/v6j9x/download`
  
      
  Descargar datos de proteínas de pez zebra de https://osf.io/68mgf/download  
`curl -o zebrafish.1.protein.faa.gz -L`  
  
  descomprimir ambos archivos
`gunzip *.protein.faa.gz`  
  
   
   crear base de datos sobre la cual se hará el blast  
`makeblastdb -in zebrafish.1.protein.faa -dbtype prot`  
  
Obtener la primera secuencia de ratón  
`head -n5 mouse.1.protein.faa > FirstMouseProt.faa`  
  
Hacer blastp de esa primera proteína contra la base de datos de pez zebra  
`blastp -query FirstMouseProt.faa -db zebrafish.1.protein.faa`  
  
  
También se puede hacer blast de muchas secuencias simultáneamente  
`head -n11 mouse.1.protein.faa > TwoMouseProt.faa`   
`blastp -query TwoMouseProt.faa -db zebrafish.1.protein.faa`  
