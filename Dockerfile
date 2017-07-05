FROM java:8-jre-alpine
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV PLAIN_OF_JARS=20170705 \
LANG=en_US.UTF-8

USER emr
WORKDIR /emr
RUN wget http://dl.bintray.com/snowplow/snowplow-generic/snowplow_emr_r89_plain_of_jars.zip \
&& unzip snowplow_emr_r89_plain_of_jars.zip \
&& rm snowplow_emr_r89_plain_of_jars.zip

USER emr
COPY assets /assets
CMD ["/assets/start.sh"]
