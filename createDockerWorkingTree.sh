#!/bin/bash
# Version 0.2
# TODO:
# - use absolute path in order to be able to call script from anywhere
# - ...
# create directory tree that contains the whole toolchain for building, running, persistence and versioning of an image and its containers
#
# DIRECTORY TREE
# - image identifier	# root directory
# |-- building		# scripts related to the build but not part of the image
# |--- image		# all files that should be included during build/execution
# |-- running		# everything required for running containers from this image
#
# USAGE
# $1 = path to directory where new folder tree is to be created
# $2 = name of the new workspace tree


IIDENT=$2
ROOT=$1${IIDENT}
BLD_NAME=build
IMG_NAME=image
BUILD=${ROOT}/${BLD_NAME}/${IMG_NAME}
RUN=${ROOT}/run

function nl(){
	printf "\n"
}

function createRoot(){
	mkdir -pv ${ROOT}
}

function createGitRepo(){
	git init ${ROOT}/
}

function createDirTree(){
	mkdir -pv ${BUILD}
	mkdir -pv ${RUN}
}

function createDockerignore(){
	local dignore=${ROOT}/.dockerignore
	local all="*"
	local image="!${BLD_NAME}/${IMG_NAME}/*"
	
	echo "${all}" > ${dignore} && \
		echo "${image}" >> ${dignore}
}

function createDockerfile(){
	touch ${ROOT}/Dockerfile
}

function createGitignore(){
	local gignore=${ROOT}/.gitignore
	local sh1="*~"
	
	echo "${sh1}" > ${gignore}
}

function createInitialCommit(){
	cd ${ROOT}/
	git add .
	git commit -a -m "Initial Commit of ${IIDENT} docker workspace"
}

# actual creation

printf "Creating workspace for ${IIDENT} ...\n"

createRoot && nl && \
createGitRepo && nl && \
createDirTree && nl && \
createDockerignore && nl && \
createDockerfile && nl && \
createGitignore && nl && \
createInitialCommit

printf "\nWorkspace for ${IIDENT} created ...\n"
