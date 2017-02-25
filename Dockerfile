FROM ubuntu
MAINTAINER Mat Sumpter <mat@matsumpter.com>

ENV DEBIAN_FRONTEND=noninteractive \
	LANG=en_US.UTF-8 \
	TERM=xterm

LABEL org.label-schema.url="https://github.com/msumpter/docker-cloud9-ide" \
	org.label-schema.name="Cloud9 IDE dockerized (Ubuntu)" \
	org.label-schema.license="MIT" \
	org.label-schema.vcs-url="https://github.com/msumpter/docker-cloud9-ide" \
	org.label-schema.schema-version="1.0"

# Install base
RUN apt-get update \
	&& apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs supervisor \
	&& curl -sL https://deb.nodesource.com/setup_4.x | bash - \
	&& apt-get install -y nodejs php-cli ruby python \
	&& git config --global url.https://.insteadOf git:// \
	&& sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf \
	&& mkdir /workspace \
	&& useradd -m cloud9 \
	&& mkdir /var/cloud9 \
	&& chown -R cloud9:cloud9 /var/cloud9

ADD supervisor-cloud9.conf /etc/supervisor/conf.d/
ADD init.sh /

VOLUME /workspace


# Drop to cloud9 user
USER cloud9
ENV HOME /home/cloud9

# Clone Cloud9
RUN git clone https://github.com/c9/core.git /var/cloud9

# Install Cloud9
WORKDIR /var/cloud9
RUN scripts/install-sdk.sh \
	&& sed -i -e 's/127.0.0.1/0.0.0.0/g' /var/cloud9/configs/standalone.js

# Switch back to root
USER root

# Clean up APT, tmp dirs, and cloud9 user
RUN apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& chmod +x /init.sh \
	&& userdel cloud9

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 3000

# Fire script /init.sh
CMD ["bash", "-c", "/init.sh"]
