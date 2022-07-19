How to run the pipeline:
1. Install NextFlow from https://www.nextflow.io/docs/latest/getstarted.html
2. Download the whole folder of the pipeline from github and move to any directory in your computer
3. Put all datafiles in the format of "*.fastq.gz" into the folder "raw_fastqs".
4. Open the file "params.yaml" and set the paramters:
        1) The parameter "input" is the absolute directory of your raw fastqs data. Do not include the "/" at the end of your directory.
        2) The parameter "project" is a BaseSpace project name that you want to call 
5. Optional, open the file "sbatch_cat_nextseq_fastqs_BSupload_NextFlow.sh" and change the paramter "--cpus-pr-task". This parameter shoulbe be equal to the number of samples if you want fastest running speed. However, the setting number should be less than the max cpu limit(For example, our HiPerGator cluster's cpu limit is 150). 
6. In terminal, run "sbatch sbatch_cat_nextseq_fastqs_BSupload_NextFlow.sh"

