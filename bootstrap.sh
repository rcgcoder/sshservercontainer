#!/bin/bash

counter=$(ps -ef | grep sshd | wc -l)
while [ $counter -gt 1 ]
do
    echo "servidor sshd activo";
    sleep 1m;
	counter=$(ps -ef | grep sshd | wc -l)
done

