FROM ubuntu:latest as build
MAINTAINER Sean Johnson <sean@ttys0.net>

#Spigot Build
ENV FILE_BUILDTOOL https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
ARG SPIGOT_VERSION=1.13.2
ENV SPIGOT_REV=${SPIGOT_VERSION}
ENV SPIGOT_BUILD_REV=${SPIGOT_VERSION}

RUN apt-get update && apt-get -y install git tar openjdk-8-jre-headless wget

RUN wget -O BuildTools.jar ${FILE_BUILDTOOL}

RUN java -jar BuildTools.jar --rev ${SPIGOT_BUILD_REV}

FROM openjdk:8u212-jre-slim
ARG MEM="2g"
ENV JVM_OPTS="-Xms${MEM} -Xmx${MEM}"
ENV SPIGOT_OPTS="nogui --noconsole"
ARG SPIGOT_VERSION=1.13.2

RUN mkdir -p /minecraft/server
CMD echo eula=true > /minecraft/server/eula.txt

COPY --from=build /spigot-${SPIGOT_VERSION}.jar /minecraft/spigot.jar
COPY --from=build /craftbukkit-${SPIGOT_VERSION}.jar /minecraft/craftbukkit.jar

WORKDIR /minecraft/server

# Expose the standard Minecraft port, and remote console port
EXPOSE 25565
EXPOSE 25575

CMD ["/bin/sh", "-c", "/usr/bin/java ${JVM_OPTS} -jar /minecraft/spigot.jar ${SPIGOT_OPTS}"]
