# podman-debian-cockpit
Debian Linux (v12 - bookworm) running systemd and cockpit


## How to use this image:

### Build it from source:
`podman build . -t debian-cockpit`

### Create the container:
`podman create --name=debian-cockpit --hostname=debian-cockpit --publish=2222:22 --publish=9090:9090 debian-cockpit`

### Allow root login:
The container will by default not be accessible, you need to add a user and provide a password and .ssh/autorized_keys file for it.

If you wish to login to cockpit as root you need to set a root password'
`podman container exec -ti debian-cockpit passwd` 

And remove the disallowed-users file:
`podman conatiner exec -ti debian-cockpit rm -f /etc/cockpit/disallowed-users`

To allow ssh login, you need to add a public key to the /root/.ssh/authrized_users file:
`cat id_rsa.pub | podman container exec -t debian-cockpit bash -c 'cat - >> /root/.ssh/authorized_keys'`

### Add another user and allow that user to login:


### Run the image:
`podman run --name debian-cockpit --publish=2222:22 --publish=9090:9090 docker.io/hurenkam/debian-cockpit:latest`


### Access cockpit or ssh
Point your browser to https://localhost:9090 where you find a running cockpit instance
or use ssh -p 2222 localhost to log into a console.


## Source:
- https://github.com/hurenkam/docker-debian-cockpit/

 
## Credits:
To get debian working with systemd, i based it on these Dockerfiles:
- https://github.com/j8r/dockerfiles/blob/master/systemd/debian/11.Dockerfile
- https://github.com/alehaa/docker-debian-systemd/blob/master/Dockerfile
