#! /bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=helloworld

srun singularity exec helloworld.sif 
