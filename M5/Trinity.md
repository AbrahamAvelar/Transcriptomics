  
basado en:  https://github.com/trinityrnaseq/RNASeq_Trinity_Tuxedo_Workshop.git    

`mkdir -p ~/rna_a`  
`cd ~/rna_a`  

Clonar los datos de:  
`git clone https://github.com/trinityrnaseq/RNASeq_Trinity_Tuxedo_Workshop.git`  
y luego ejecutar el docker 
Directorio local `/home/alumno1/transcriptomics/RNASeq_Trinity_Tuxedo_Workshop` mapea al directorio remoto `/home`  


Para entrar al docker   
docker run --rm -i -t  -v /home/alumno1/transcriptomics/RNASeq_Trinity_Tuxedo_Workshop:/home trinityrnaseq/trinityrnaseq   /bin/bash

Trinity  --seqType fq --SS_lib_type RF --left /home/RNASEQ_data/Sp_log.left.fq.gz --right /home/RNASEQ_data/Sp_log.right.fq.gz --max_memory 1G --CPU 4  --output /home/trinity_out --full_cleanup


docker run --rm -v /home/alumnoX/RNASeq_Trinity_Tuxedo_Workshop:/home trinityrnaseq/trinityrnaseq Trinity   
docker run --rm -v /home/alumnoX/RNASeq_Trinity_Tuxedo_Workshop:/home trinityrnaseq/trinityrnaseq Trinity  --seqType fq --SS_lib_type RF --left /home/RNASEQ_data/Sp_log.left.fq.gz --right /home/RNASEQ_data/Sp_log.right.fq.gz --max_memory 1G --CPU 4  --output /home/trinity_out --full_cleanup
  
head trinity_out_dir.Trinity.fasta



