FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
    cron git python3-pip \
    python3-psycopg2 python3-pil \
    python3-yaml python3-requests && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade knowledge-repo[all]

# R support - can be very big - not tested
#RUN apt-get update && \
#  apt-get install r-base-core && \
#  R -e 'install.packages("rmarkdown")'

WORKDIR /app/
ADD docker .

ADD crontab /etc/cron.d/kr-cron
RUN chmod 0644 /etc/cron.d/kr-cron
RUN chmod +x /app/git-clone.sh

RUN touch /var/log/cron.log
# CMD cron && tail -f /var/log/cron.log

CMD bash /app/start.sh 
