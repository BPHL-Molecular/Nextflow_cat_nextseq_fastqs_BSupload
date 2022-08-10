############################
What to do:
The pipeline is developed using NextFlow workflow. It can mix the NGS sequensing data from multiple lanes into one dataset for each sample. As parallel algorithm is applied in the pipeline, the running speed will be greatly improved when there are a lot of samples to handle.  


###########################
How to run the pipeline:
1. Install NextFlow:
      1) Use curl or wget to install, see https://www.nextflow.io/docs/latest/getstarted.html
      2) Use conda or mamba to install Nextflow:
             $conda install -c conda-forge mamba
             $mamba create -n nextflow -c bioconda -c conda-forge nextflow=21.10.6
         Then activate the environment with:
             $conda activate nextflow            
2. Download the whole folder of the pipeline from github and move to any directory in your computer
3. Put all datafiles in the format of "*.fastq.gz" into the folder "raw_fastqs".  Note: the pipeline can only mix the sample with 4 lanes of paired data files. Namely, for each sample, there are "...L001...R1...fastq.gz", "...L002...R1...fastq.gz", "...L003...R1...fastq.gz", "...L004...R1...fastq.gz","...L001...R2...fastq.gz", "...L002...R2...fastq.gz", "...L003...R2...fastq.gz", "...L004...R2...fastq.gz".
4. Open the file "params.yaml" and set the paramters:
        1) The parameter "input" is the absolute/complete path of the directory of your raw fastqs data. Do not include the "/" at the end of the path.
        2) The parameter "project" is a BaseSpace project name that you want to call 
5. Optionally, open the file "sbatch_cat_nextseq_fastqs_BSupload_NextFlow.sh" and change the paramter "--cpus-pr-task". This parameter shoulbe be equal to the number of samples if you want fastest running speed. However, the setting number should be less than the max cpu limit(For example, the HiPerGator cluster's cpu limit is 150 for our group). 
6. In terminal, run "sbatch sbatch_cat_nextseq_fastqs_BSupload_NextFlow.sh"

