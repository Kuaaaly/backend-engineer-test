FROM ubuntu

RUN apt-get update\
 && apt-get install jq vim git\
 && git clone https://github.com/Kuaaaly/backend-engineer-test.git
