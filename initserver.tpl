#!/bin/bash
yum update -y
yum install -y python3 pip python3-flask
pip install Flask
cd /home/ec2-user/application/ && flask run --host=0.0.0.0 --port 80