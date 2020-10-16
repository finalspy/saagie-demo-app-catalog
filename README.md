# Saagie's experimental image for Elasticsearch

The purpose of this project is to demo a simple adaptation of an existing webapp docker image to allow it to run inside Saagie's platform

We used an official elasticsearch 7.9.0 image for that.

Note the 9300 TCP port is used for binary inter ES nodes communication and as this projects assumes a single node it's useless here.
But we keep it and do some configuration on it only for educationnal purpose to show how ports and path can be customized usinf variables etc.

Target image can be found on [DockerHub](https://hub.docker.com/layers/ypetit/test/es-7.9.0/images/sha256-481a1db483713cf1ede8fd4a31d085d9548b4cdd1a1a2b41492f86981f1004a9?context=repo&tab=layers)


## structure 

./docker contains resources to build the Docker image

./technologies contains the resources to create an app catalog zip for Saagie's platform

## Build image 

First open a terminal and cd to ./docker directory

To build default image bases on  docker.elastic.co/elasticsearch/elasticsearch:7.9.0

     docker build -t <repositoryName/imageName:tagName> .

replace by appropriate values texts betwenn <>, for example :

     docker build -t ypetit/test:es-7.9.0 .

To build another version you can pass $DOCKER_VERSION as argument

    docker build --build-arg DOCKER_VERSION=7.9.2 -t ypetit/test:es-7.9.2 .

## Run image locally 

To access ES on localhost go to http://localhost:9200/[\$ES_PATH] for REST (ie. http access)
(By default \$ES_PATH and \$ES2_PATH are configures to "/")

To run in background and access on http://localhost:9200/ and http://localhost:9300/ 

    docker run -d -p 9200:8200 -p 9300:8300 ypetit/test:es-7.9.0

To run interactively ina container called 'tmp', see logs, and terminate the process and remove the container when exiting :

    docker run --rm -it --name tmp  -p 9200:8200 -p 9300:8300 ypetit/test:es-7.9.0

To specify a custom path and port and access it on  http://localhost:1092/REST and http://localhost:1093/nodes (for demo purpose only as binary tcp won't work this way) 

    docker run --rm -it --name tmp -e ES_PATH=/REST -e ES2_PATH=/nodes -p 1092:8200 -p 1093:8300 ypetit/test:es-7.9.0

## Run image on Saagie

For that we must reference the docker file in a metadata.yaml file which it self will be added to a zip file that will be sued as an app catalog for Saagie's platform.

In the metadata we must match the port numbers 8200 and 8300 and the path variables \$ES_PATH and \$ES2_PATH (as we make variable substitutions, be carefull not to overlap the two names if you decide to chang them in the image or you'll get into troubles).

    version: v1
    type: APP
    id: elasticsearch
    label: Elastic Search
    baseline: Technology basseline for elasticsearch
    description: Technology description for elasticsearch
    available: true
    icon: kibana
    backgroundColor: "#22FFAA"
    customFlags: []
    contexts:
    - id: 7.9.0
        label: ES 7.9.0
        releaseNotes: "Release Note for ES 7.9.0"
        available: true
        trustLevel: experimental
        ports:
        - port: 8200
            name: es REST port
            rewriteUrl: false
            basePath: ES_PATH
        - port: 8300
            name: es nodes binary communication port
            rewriteUrl: false
            basePath: ES2_PATH
        dockerInfo:
          image: ypetit/test
          version: es-7.9.0-new

Double check that iamge and version match a publicly available docker image (ie if you build it locally don't forgetto push it to a public docker repository)

Note: we use a kibana icon in the above file as the elasticsearch one wasn't available by the dime we did this demo. 

Note: colors are arbitrarily choosen 


