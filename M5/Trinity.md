  
basado en:  https://github.com/trinityrnaseq/RNASeq_Trinity_Tuxedo_Workshop.git    

Clonar los datos de:  
git clone `https://github.com/trinityrnaseq/RNASeq_Trinity_Tuxedo_Workshop.git`  
y luego ejecutar el docker 

docker run --rm -v /home/alumnoX/rna_a/RNASeq_Trinity_Tuxedo_Workshop:/home trinityrnaseq/trinityrnaseq Trinity   
docker run --rm -v /home/alumnoX/rna_a/RNASeq_Trinity_Tuxedo_Workshop:/home trinityrnaseq/trinityrnaseq Trinity  --seqType fq --SS_lib_type RF --left /home/RNASEQ_data/Sp_log.left.fq.gz --right /home/RNASEQ_data/Sp_log.right.fq.gz --max_memory 1G --CPU 4  --output /home/trinity_out --full_cleanup
  
head trinity_out_dir.Trinity.fasta


