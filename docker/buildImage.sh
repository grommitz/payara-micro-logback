#!/usr/bin/env bash

#########################################################################################
# All-in-1 script to build the docker image for payara-micro-logback.
#
# This script is different to the buildImage script in other projects. It does not require
# any user input params. It reads the version of payara-micro used from a filtered
# resource file, and from this is knows the version of the payara-micr-logback jar and
# the tag name for the image.
#########################################################################################

# APP must be the same as the artifactId in the pom file
APP=payara-micro-logback
IMAGE_NAME=payara-micro-logback

VER_FILE=../target/classes/payara-version
if [ ! -e "$VER_FILE" ]; then
    echo "$VER_FILE does not exist: build the project with maven before building the docker image"
    exit 1
fi

VERN=`cat $VER_FILE | head -1 | xargs`

NEXUS=devhub.envisional.co.uk:8081
PUSH=N
REG=docker.brandprotection.net
REGW=dockerw.brandprotection.net

PAYARA_VER="$VERN"
APP_VER=$PAYARA_VER
IMAGE_VER="$VERN"
if [[ $1 == "-push" ]]; then
  PUSH=Y
fi

echo "--------------------------------------------------------------------------------------------"
echo "                                     BUILD INFO                                             "
echo "--------------------------------------------------------------------------------------------"
echo "Payara micro version               : ${PAYARA_VER}"
echo "Image to be created                : ${REG}/${IMAGE_NAME}:${PAYARA_VER}"
echo "Push the new image to the registry : ${PUSH}"
echo

read -p "Proceed [y/n]? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
fi
echo
echo "Building...."

JAR=../target/payara-micro/$APP-$PAYARA_VER.jar
LIBS=../target/payara-micro/libs/*

if [ ! -e "$JAR" ]; then
    echo "$JAR does not exist: build the project with maven before building the docker image"
    exit 1
fi

cp ${JAR} ./payara-micro-logback.jar || { echo "Missing artifact file ${JAR}"; exit 1; }
rm -rf libs
mkdir libs
cp ${LIBS} ./libs

echo "Building the docker image..."
docker build --build-arg PAYARA_VER=$PAYARA_VER -t ${REG}/${IMAGE_NAME}:${IMAGE_VER} . || { echo "Failed to build image."; exit 1; }

# add the extra tag for dockerw
docker tag ${REG}/${IMAGE_NAME}:${IMAGE_VER} ${REGW}/${IMAGE_NAME}:${IMAGE_VER} || { echo "Failed to tag image."; exit 1; }

# push to the registry
if [[ $PUSH = Y ]]; then
  echo "Pushing image to docker registry at ${REGW}..."
  docker push ${REGW}/${IMAGE_NAME}:${IMAGE_VER}
else
  echo "Not pushing to docker registry"
fi

echo "Done."