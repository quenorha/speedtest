FROM debian:buster-slim
RUN apt update && apt install -y curl sudo cron
# install instruction: https://www.speedtest.net/apps/cli
RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
RUN apt install -y speedtest
RUN mkdir /var/log/speedtest
# change server for speed test by altering value of argument "-s"
# https://crontab.guru/#*/1_*_*_*_*
RUN echo "*/1 * * * * root /bin/rm /var/log/speedtest/*.json" > /etc/cron.d/removefiles
RUN echo "*/1 * * * * root /usr/bin/speedtest --accept-license --accept-gdpr -s 23282 -f json > \$(mktemp -u -p /var/log/speedtest XXXXXX).json" > /etc/cron.d/speedtest
CMD ["cron", "-f"]
