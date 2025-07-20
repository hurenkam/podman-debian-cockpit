# Build the image
podman build . -t debian-cockpit

# Create the container:
podman create --name=debian-cockpit --hostname=debian-cockpit --publish=2222:22 --publish=9090:9090 debian-cockpit

# Allow root login
podman container exec -ti debian-cockpit passwd
podman conatiner exec -ti debian-cockpit rm -f /etc/cockpit/disallowed-users
cat ~/.ssh/*.pub | podman container exec -t debian-cockpit bash -c 'cat - >> /root/.ssh/authorized_keys'

### Run the image:
`podman run --name debian-cockpit --publish=2222:22 --publish=9090:9090 docker.io/hurenkam/debian-cockpit:latest`

