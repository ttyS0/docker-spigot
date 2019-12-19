FROM adoptopenjdk/openjdk11:alpine-jre

VOLUME ["/plugins", "/config"]
WORKDIR /server

ENV BUNGEE_HOME=/server
ENV BUNGEE_BUILD=1428
ENV BUNGEE_FILE=https://ci.md-5.net/job/BungeeCord/${BUNGEE_BUILD}/artifact/bootstrap/target/BungeeCord.jar
ENV MEMORY=512m

RUN wget -O ${BUNGEE_HOME}/BungeeCord.jar ${BUNGEE_FILE}

COPY *.sh /usr/bin/

RUN apk --no-cache add curl bash sudo

EXPOSE 25565

RUN set -x \
	&& addgroup -g 1000 -S bungeecord \
	&& adduser -u 1000 -D -S -G bungeecord bungeecord \
	&& addgroup bungeecord wheel

CMD ["/usr/bin/run-bungeecord.sh"]
