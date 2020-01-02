# ansible-docker
Scripts, Docker-Compose, Dockerfile to create docker containers for ansible learning env.
- Dockerfile: Dockerfile is set of instructions to create new dockerized centos8 systemd, ssh enabled image
- docker-compose.yml: docker-compose file is used to create dockerized learning env. which will build your docker image and start containers.


# How to use:

with Scripts: 
- Generate id_rsa.pub 
  ssh-keygen -t rsa -f "path to your directory"
  
- you can manually create docker image, Dockefile is available in git repository
 docker build -t "image-name" .

- and start conainters by executing,
  ./container.sh

#with Docker-compose:
- build image: 
  docker-compose build or docker-compose up -d build

- Create and Start Conainers:
  docker-compose up -d 

To test ansible, user "user" is already available on docker containers, you will have to setup
 passwordless authentication between your host and containers
