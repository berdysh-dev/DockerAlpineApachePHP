PHP = php
USER = berdyshdev2
REPO = docker_alpine_apache_php
TAG = latest
NAME = work

UID = berdyshdev2

all: kill rmi build run

build:
	docker build -f Dockerfile --tag=${TAG} --rm=true .

run2:
	docker run `${PHP} DockerUtil.php -ImageID ${TAG}`

run:
	docker run \
-p 443:443 \
-p 80:80 \
-v /etc:/usr/local/etc \
`${PHP} DockerUtil.php -ImageID ${TAG}`

stop:
	docker stop `${PHP} DockerUtil.php -ImageID ${TAG}`

sh2:
	${PHP} DockerUtil.php -ContainerID ${TAG}

sh:
	@docker exec -it `${PHP} DockerUtil.php -ContainerID ${TAG}` sh

login:
	docker login -u=${UID}

logout:
	docker logout

con:
	${PHP} DockerUtil.php -ContainerID ${TAG}

im:
	${PHP} DockerUtil.php -ImageID ${TAG}

ps:
	${PHP} DockerUtil.php -Ps_A ${TAG}

commit:
	@echo docker container commit `${PHP} DockerUtil.php -ContainerID ${TAG}` ${USER}/${REPO}
	@docker container commit `${PHP} DockerUtil.php -ContainerID ${TAG}` ${USER}/${REPO}

tag:
	@echo docker tag `${PHP} DockerUtil.php -ImageID ${TAG}` ${USER}/${REPO}
	@docker tag `${PHP} DockerUtil.php -ImageID ${TAG}` ${USER}/${REPO}

push:
	docker push ${USER}/${REPO}

pull:
	docker pull ${USER}/${REPO}:latest

rmi:
	${PHP} DockerUtil.php -rmi

kill:
	${PHP} DockerUtil.php -kill


# Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg.

