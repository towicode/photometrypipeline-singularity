# Photometry Pipeline Docker and Singularity Build

This repository contains the instructions, tests and other information for building the docker and singularity images for the photometry-pipeline. The corosponding docker image can be found here [https://hub.docker.com/r/toddwickizer/photometrypipeline-singularity/](https://hub.docker.com/r/toddwickizer/photometrypipeline-singularity/).

The actual photometrypipeline source can be found here [https://github.com/mommermi/photometrypipeline](https://github.com/mommermi/photometrypipeline)


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

* __Installing Singularity__

  See http://singularity.lbl.gov/install-linux
  > __Note__: You need to install from source. Do NOT install version 2.2

* __Installing Docker__  

  See https://docs.docker.com/engine/installation/
  > __Note__: Make sure you get the correct version, avoid installing from the default repositories
  
---------------------------------------------------------------------------------------------------------------------------- 
 
### Getting the docker image

  Grabbing the docker image is as simple as using the docker cli. The [docker pull](https://docs.docker.com/engine/reference/commandline/pull/) pulls an image from a docker repository.

  To grab the latest version:

  `docker pull toddwickizer/photometrypipeline-singularity`

  To grab a specific version:

  `docker pull toddwickizer/photometrypipeline-singularity:<version_tag>`

  > __Note__: This may take a minute to download as the image tends to be 500mb+


### Running pp_run from your docker image.

  Running a shell requires using the [docker run](https://docs.docker.com/engine/reference/run/) command.

  `docker run -i -t toddwickizer/photometrypipeline-singularity /bin/bash`

  Explanation of the above command:

  `run` executes the image, with additional arguments to be ran.  
  `-i` creates an interactive session  
  `-t` tells docker to run the image 'tagged' with toddwickizer/...  
  `/bin/bash` tells docker to execute the shell after the image is loaded.  

  Once you are inside the docker-shell you can run pp_run with test data to verify the docker shell is working  
    1. `cd example_data/vatt4k` Navigate to where the test file is  
    2. `pp_run mscience0217.fits` Execute the pp_run program with the test file as an argument.  

---------------------------------------------------------------------------------------------------------------------------

### Creating singularity image 

No need to download anything from this repository! Simply type:

     docker run \        
     -v /var/run/docker.sock:/var/run/docker.sock \
     -v path\where\to\ouptut\singularity\image:/output \
     --privileged -t --rm \
     singularityware/docker2singularity \            
     toddwickizer/photometrypipeline-singularity

Replace `path\where\to\ouptut\singularity\image` with a path on the host filesystem where your Singularity image will be created. `toddwickizer/photometrypipeline-singularity` is the docker image provided (it will be pulled from Docker Hub if it does not exist on your host system).

`docker2singularity` uses the Docker daemon located on the host system. It will access the Docker image cache from the host system avoiding having to redownload images that are already present locally.


### Running pp_run from you singularity image

1. Ensure you are currently in a directory where there is a .fits or other test file.
2. `singularity exec path\where\to\ouptut\singularity\image\<image_name>.img pp_run <test_file>.fits`


### Uploading the image to HPC 
1. make sure you have ssh no password verification with sftp.hpc.arizona.edu
2. Edit the following command `rsync -avz  /home/todd/dockerpipe twickizer@sftp.hpc.arizona.edu:/extra/twickizer`

So that `/home/todd/dockerpipe` is the path to your directory and `/extra/twickizer` is your own personal extra space on HPC.

