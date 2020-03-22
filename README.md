# Moodle-Dockerfile

Deploy quick & dirty a Moodle website

**Debian based php/apache (FROM php:7.1-apache-buster)**

The package has a hardlink to actual Moodle 3.8.2 stable 
from https://download.moodle.org/releases/latest/

Prerequisite :
docker, docker-compose

Don't forget to change your mariadb password in the docker-compose.yml file line 16 to 18

Build the docker image using:
`docker build -t moodle .`

Wait for some minutes to let it finish
Then deploy with
`docker-compose up -d`

You site will be available at port 9595 
(you can change this by whatever seems relevant, or serve it behind a proxy)

It's quick and ugly, no check-sum from download, but... 

I kept it simple

(may make it better later...)
