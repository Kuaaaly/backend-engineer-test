FROM ubuntu

RUN apt-get update\
 && apt-get -y install jq vim git\
 && cd /root && git clone https://github.com/Kuaaaly/backend-engineer-test.git
