#!/bin/bash
#PBS -N photometry-pipeline-singularity-job
#PBS -W group_list=pi
#PBS -q windfall
#PBS -j oe
#PBS -l select=1:ncpus=1:mem=6gb
#PBS -l walltime=01:00:00
#PBS -l cput=12:00:00
module load singularity
cd /extra/twickizer/dockerpipe/tests
singularity exec ../pipe.img pp_run mscience0217.fits
date
