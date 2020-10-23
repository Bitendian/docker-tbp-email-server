# Base image
FROM debian:10.5-slim

# Set env var for install process
ENV DEBIAN_FRONTEND="noninteractive"

# Postfix install process
RUN apt-get update && \
    apt-get install -y mailutils && \
    apt-get install -y postfix


# Unset env var for install process
ENV DEBIAN_FRONTEND newt

# Postfix config
ENV POSTFIX_MYHOSTNAME no-reply.bitendian.com
ENV POSTFIX_MYDESTINATION \$myhostname, localhost.\$mydomain, localhost
ENV POSTFIX_MYDOMAIN bitendian.com

COPY main.cf /etc/postfix/main.cf
COPY /bin/run.sh /etc/postfix/bin/run.sh

RUN chmod +x /etc/postfix/bin/run.sh
ENTRYPOINT /etc/postfix/bin/run.sh $POSTFIX_MYHOSTNAME $POSTFIX_MYDESTINATION $POSTFIX_MYDOMAIN


