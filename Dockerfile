# Base image
FROM debian:10.5-slim

# Set env var for install process
ENV DEBIAN_FRONTEND="noninteractive"

# Postfix install process
RUN apt-get update
RUN apt-get install -y mailutils
RUN apt-get install -y postfix

# Unset env var for install process
ENV DEBIAN_FRONTEND newt

# Postfix config
ARG DOMAIN
COPY main.cf etc/postfix/main.cf
RUN sed -i 's|mydestination = |&'$DOMAIN', |' /etc/postfix/main.cf
RUN sed -i 's|unix  -       -       y       -       -       smtp|unix  -       -       n       -       -       smtp|' /etc/postfix/master.cf


COPY run.sh / 
RUN chmod +x /run.sh
CMD ["/run.sh"]

