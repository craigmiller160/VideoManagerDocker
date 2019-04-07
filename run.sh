#!/bin/bash

rm binaries/*
cp ../VideoManagerClient/dist/*.zip binaries
cp ../VideoManagerServer/target/*.jar binaries
sudo -E docker-compose stop
sudo -E docker-compose build
sudo -E docker-compose up -d