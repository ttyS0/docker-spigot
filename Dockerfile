FROM adoptopenjdk:16-jdk as build
MAINTAINER Sean Johnson <sean@ttys0.net>

LABEL org.opencontainers.image.source = "https://github.com/ttyS0/docker-spigot"

#Spigot Build
ENV FILE_BUILDTOOL https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
ARG SPIGOT_VERSION=1.17.1
ENV SPIGOT_REV=${SPIGOT_VERSION}
ENV SPIGOT_BUILD_REV=${SPIGOT_VERSION}

RUN apt-get update && apt-get -y upgrade && apt-get -y install git wget

RUN wget -O BuildTools.jar ${FILE_BUILDTOOL}

RUN echo "#!/bin/bash" > /tmp/build_spigot.sh && echo "java -jar BuildTools.jar --rev ${SPIGOT_BUILD_REV}" >> /tmp/build_spigot.sh && chmod a+x /tmp/build_spigot.sh && /tmp/build_spigot.sh

FROM adoptopenjdk:16-jre
ARG MEM="2g"
ENV JVM_OPTS="-Xms${MEM} -Xmx${MEM}"
ENV SPIGOT_OPTS="nogui --noconsole"
ARG SPIGOT_VERSION=1.17.1
ENV SPIGOT_DIR="/minecraft/server"

RUN mkdir -p ${SPIGOT_DIR}

COPY --from=build /spigot-${SPIGOT_VERSION}.jar /minecraft/spigot.jar
COPY run-spigot.sh /usr/bin/
RUN chmod a+x /usr/bin/run-spigot.sh

WORKDIR ${SPIGOT_DIR}

# Expose the standard Minecraft port, and remote console port
EXPOSE 25565
EXPOSE 25575

CMD ["/usr/bin/run-spigot.sh"]
