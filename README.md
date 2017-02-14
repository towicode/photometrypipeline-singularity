



# Requirements #

### Installing Singularity ###

See http://singularity.lbl.gov/install-linux

note: you will HAVE to install from source

if you are on ubuntu 16+ you will need the following
`sudo apt-get install -y build-essential libtool autotools-dev automake autoconf`

### Installing docker ###
https://docs.docker.com/engine/installation/

note: Make sure you get the correct version, avoid installing from the default repositories




--------------------------------------------------------------------------------------------



# Pulling this directory #

Clone this directory with `git clone`

Note: Make sure to take note of where you put the files.

# Creating singularity image #

We will actually be using a docker image to create our singularity image. 

`docker run -v /var/run/docker.sock:/var/run/docker.sock -v /home/todd/dockerpipe:/output --privileged -t --rm singularityware/docker2singularity toddwickizer/photometrypipeline `

You will need to edit the above line where `/home/todd/dockerpipe` where you pulled this github directory. 
This will place a .img file in that directory. The .img file will be a bundled singularity docker file with all the requirements for the pipeline built in. 

Note: I prefer to rename my .img file once it has been created. `mv toddwickizer...img pipe.img`


# Testing singularity image #

Go into the tests directory

`cd tests`

then run the command

`singularity exec ../pipe.img pp_run mscience0217.fits`


You should get the results of that test.


# Uploading the image to HPC #
1. make sure you have ssh no password verification with sftp.hpc.arizona.edu
2. Edit the following command `rsync -avz  /home/todd/dockerpipe twickizer@sftp.hpc.arizona.edu:/extra/twickizer`

So that `/home/todd/dockerpipe` is the path to your directory and `/extra/twickizer` is your own personal extra space on HPC.

