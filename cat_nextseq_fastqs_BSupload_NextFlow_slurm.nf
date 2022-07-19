#!/usr/bin/env nextflow

/*
Note:
Before running the script, please set the parameters in the config file params.yaml
*/

nextflow.enable.dsl=2

def L001R1Lst = []
myDir = file("$params.input")
myDir.eachFileMatch ~/.*L001_R1.*/, {L001R1Lst << it.name}
L001R1Lst.sort()

def sampleNames = []
L001R1Lst.each{
	def x = it.minus("_L001_R1_001.fastq.gz")
	//println x
	sampleNames.add(x)
}
//println L001R1Lst
//println sampleNames
A = Channel.fromList(sampleNames)
//A.view()

"bs create project -n ${params.project}".execute()

//mix 1-4 lanes of each sample, and then upload mixted result of each sample to the project in BaseSpace Sequence Hub
process mixLanes {
   input:
      val x
   output:
      path 'xfile.txt', emit: aLook
      //path "cat_${x}_L001_R*_001.fastq.gz", emit: mixedR
      //path "cat_${x}_L001_R2_001.fastq.gz", emit: mixedR2
      
   """  
   echo ${params.input}/${x}_L001_R1_001.fastq.gz >> xfile.txt
   echo ${params.input}/${x}_L002_R1_001.fastq.gz >> xfile.txt
   echo ${params.input}/${x}_L003_R1_001.fastq.gz >> xfile.txt
   echo ${params.input}/${x}_L004_R1_001.fastq.gz >> xfile.txt
   echo ${params.input}/${x}_L001_R2_001.fastq.gz >> yfile.txt
   echo ${params.input}/${x}_L002_R2_001.fastq.gz >> yfile.txt
   echo ${params.input}/${x}_L003_R2_001.fastq.gz >> yfile.txt
   echo ${params.input}/${x}_L004_R2_001.fastq.gz >> yfile.txt
   zcat ${params.input}/${x}_L001_R1_001.fastq.gz ${params.input}/${x}_L002_R1_001.fastq.gz ${params.input}/${x}_L003_R1_001.fastq.gz ${params.input}/${x}_L004_R1_001.fastq.gz > cat_${x}_L001_R1_001.fastq
   cat cat_${x}_L001_R1_001.fastq | gzip > ${x}_L001_R1_001.fastq.gz  
   zcat ${params.input}/${x}_L001_R2_001.fastq.gz ${params.input}/${x}_L002_R2_001.fastq.gz ${params.input}/${x}_L003_R2_001.fastq.gz ${params.input}/${x}_L004_R2_001.fastq.gz > cat_${x}_L001_R2_001.fastq
   cat cat_${x}_L001_R2_001.fastq | gzip > ${x}_L001_R2_001.fastq.gz
   project_id=\$(bs list project --filter-term=${params.project} --template={{.Id}})   
   bs upload dataset -p \${project_id} ${x}_L001_R1_001.fastq.gz ${x}_L001_R2_001.fastq.gz
   """
}

workflow {
	mixLanes(A)
	//mixLanes.out.aLook.view()		
}

