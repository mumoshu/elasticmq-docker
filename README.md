# ElasticMQ-Docker

[![Build Status](https://travis-ci.org/mumoshu/elasticmq-docker.svg?branch=master)](https://travis-ci.org/mumoshu/elasticmq-docker)

Alpine Linux based Containerized [ElasticMQ](https://github.com/adamw/elasticmq) forked from [behance/elasticmq-docker](https://github.com/behance/elasticmq-docker)
Used for dev environments that [integrate with AWS SQS](http://labs.encoded.io/2013/02/03/testing-amazon-sqs-locally-with-elasticmq/)

By default, the run script for this container will attempt to parse the IP of the docker bridge that the container is attached to and place it into the REST config. You **can** override it by just passing in an IP/address, however this is not recommended.

[Docker Hub](https://hub.docker.com/r/mumoshu/elasticmq)
