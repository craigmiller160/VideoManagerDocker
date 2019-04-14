#!/bin/bash

function clean {
    echo "Running Clean"
    rm binaries/*.zip
    rm binaries/*.jar
}

function copy {
    echo "Running Copy"
    clean
    cp ../VideoManagerClient/dist/*.zip binaries
    cp ../VideoManagerServer/target/*.jar binaries
}

function build {
    echo "Running Build"
    stop
    clean
    copy
    sudo -E docker-compose build
}

function start {
    echo "Running Start"
    stop
    sudo -E docker-compose up -d
}

function start_db {
    echo "Running Start-DB"
    stop
    sudo -E docker-compose up -d postgres pgadmin
}

function stop {
    echo "Running Stop"
    sudo -E docker-compose stop
}

function setup {
    echo "Creating postgres docker volume"
    mkdir -p ~/.video-manager/postgres
    echo "Creating pgadmin docker volume"
    mkdir -p ~/.video-manager/pgadmin
}

function export {
    echo "Running export"
    sudo docker exec postgres pg_dump vm_prod -U user --column-inserts --data-only
}

function help {
    echo "Video Manager Script Help"
    echo ""
    echo "build = Re-build the docker containers for the client and server apps. Runs stop, clean and copy first."
    echo "clean = Cleans the binaries directory of any applications."
    echo "copy = Copies the new application binaries to the binaries directory. Runs clean first."
    echo "export = Exports the prod data so it can be backed up"
    echo "help = Open this help menu"
    echo "start = Starts the docker containers for the entire application. Runs stop first."
    echo "start-db = Stars only the database containers. Runs stop first."
    echo "stop = Stops the docker containers"
}

function parse_command {
    case $1 in
        "build") build ;;
        "clean") clean ;;
        "copy") copy ;;
        "export") export ;;
        "help") help ;;
        "start") start ;;
        "start-db") start_db ;;
        "stop") stop ;;
        *)
            echo "Error! Invalid argument: $1"
            echo "For help, please run 'video-manager.sh help'"
        ;;
    esac
}

if [[ $# -eq 0 ]]; then
    echo "Error! Must provide the name of the action to perform."
    echo "For help, please run 'video-manager.sh help'"
    exit 1
fi

cd ./docker

parse_command $1