FROM ubuntu:14.04

ADD build/linux/amd64/drone-k8s /opt/service/bin/entrypoint
ADD conf /opt/service/conf

# allow app to create template from conf, and log to disk
RUN mkdir -p /var/log/service /var/run/service && \
	chown -R daemon:daemon /opt/service/conf /var/run/service /var/log/service

# symlink hootconf.key for kubernetes containers
RUN ln -s /etc/secrets/hootconf.key /etc/hootconf.key

WORKDIR /opt/service
USER daemon

ENTRYPOINT ["/opt/service/bin/entrypoint"]
CMD ["--scheme=http", "--port=8080", "--host=0.0.0.0"]
