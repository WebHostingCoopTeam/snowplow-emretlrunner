FROM jruby:9.1-alpine
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV PLAIN_OF_JARS=20170705 \
LANG=en_US.UTF-8

RUN apk update \
&& apk upgrade \
&& apk add bash openssl gettext libintl \
&& rm -rf /var/cache/apk/*

RUN adduser -S emr \
&& mkdir -p /emr \
&& chown -R emr. /emr

USER emr
WORKDIR /emr
RUN wget -c http://dl.bintray.com/snowplow/snowplow-generic/snowplow_emr_r89_plain_of_jars.zip \
&& unzip snowplow_emr_r89_plain_of_jars.zip \
&& rm snowplow_emr_r89_plain_of_jars.zip

USER emr
USER root
COPY assets /assets
CMD ["/assets/start.sh"]
