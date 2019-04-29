FROM ubuntu

COPY . /root

RUN apt-get update\
 && apt-get install jq vim git\
 && cd /root && git clone https://github.com/Kuaaaly/backend-engineer-test.git

CMD ["/root/exercise.sh"]

