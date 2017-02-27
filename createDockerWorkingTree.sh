#!/bin/bash
# Version 0.1
# TODO:
# - use absolute path in order to be able to call script from anywhere
# - ...
# create directory tree that contains the whole toolchain for building, running, persistence and versioning of an image and its containers
# directory tree
# - image identifier
# |-- building
# |--- image
# |-- running
# |-- volumes



IIDENT=$1
ROOT=$(pwd)/${IIDENT}
BLD_NAME=build
IMG_NAME=image
BUILD=${ROOT}/${BLD_NAME}/${IMG_NAME}
RUN=${ROOT}/run
VOL_NAME=volumes
VOL=${ROOT}/${VOL_NAME}

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
	mkdir -pv ${VOL}
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
	local sh1=".*~"
	local sh2="*~"
	local vol1="${VOL_NAME}/"
	local vol2="${VOL_NAME}/*"
	
	echo "${sh1}" > ${gignore} && \
		echo "${sh2}" >> ${gignore} && \
		echo "${vol1}" >> ${gignore} && \
		echo "${vol2}" >> ${gignore}
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
