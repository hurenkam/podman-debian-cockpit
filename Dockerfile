FROM debian:bookworm
MAINTAINER Mark Hurenkamp <mark.hurenkamp@xs4all>


# install base packages
# systemd / ssh / vim / ip utils
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
	systemd \
	systemd-sysv \
        cron \
        anacron \
	openssh-server \
	vim \
	iproute2

# install minimum cockpit packages
# for system administration
RUN apt-get update && apt-get install -y \
	cockpit-bridge \
	cockpit-ws \
	cockpit-system

# Make sure that there's a place to put authorized_keys
RUN mkdir -p /root/.ssh

# clean-up after apt
RUN apt-get clean && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /var/log/alternatives.log \
    /var/log/apt/history.log \
    /var/log/apt/term.log \
    /var/log/dpkg.log


# Remove the machine's id, so that each container
# will generate a unique new id
RUN rm -f \
    /etc/machine-id \
    /var/lib/dbus/machine-id

# remove deleted files from intermediate layers
FROM debian:bookworm
COPY --from=0 / /


# expose ssh port
EXPOSE 22

# expose cockpit port
EXPOSE 9090

# start systemd
CMD [ "/sbin/init" ]

