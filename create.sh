# Build the image
podman build . -t debian-cockpit

# Create the container:
podman create --name=debian-cockpit --hostname=debian-cockpit --publish=2222:22 --publish=9090:9090 debian-cockpit

# Start the container:
podman container start debian-cockpit

# Allow root login
podman container exec -ti debian-cockpit passwd
podman container exec debian-cockpit rm -f /etc/cockpit/disallowed-users
cat ~/.ssh/*.pub | podman container exec debian-cockpit bash -c 'cat - >> /root/.ssh/authorized_keys'

