#!/bin/bash

sudo docker exec postgres pg_dump vm_prod -U user --column-inserts --data-only