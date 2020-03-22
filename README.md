# Moodle-Dockerfile

Deploy quick & dirty a Moodle website

**Debian based php/apache (FROM php:7.1-apache-buster)**

The package has a hardlink to actual Moodle 3.8.2 stable 
from https://download.moodle.org/releases/latest/

Prerequisite :
docker, docker-compose

Build the docker image using:
`docker build -t moodle .`

Wait for some minutes to let it finish
Then deploy with
`docker-compose up -d`

It's quick and ugly, no check-sum from download, but... it kept it simple
may make it better later...
