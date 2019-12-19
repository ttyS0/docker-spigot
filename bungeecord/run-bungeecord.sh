#!/bin/bash

BUNGEE_JAR=/server/BungeeCord.jar

if [ -d /plugins ]; then
  echo "Copying BungeeCord plugins over..."
  cp -r /plugins $BUNGEE_HOME
fi

if [ -d /config ]; then
  echo "Copying BungeeCord configs over..."
  cp -u /config/config.yml "$BUNGEE_HOME/config.yml"
fi

if [ $UID == 0 ]; then
  chown -R bungeecord:bungeecord $BUNGEE_HOME
fi

echo "Setting initial memory to ${INIT_MEMORY:-${MEMORY}} and max to ${MAX_MEMORY:-${MEMORY}}"
JVM_OPTS="-Xms${INIT_MEMORY:-${MEMORY}} -Xmx${MAX_MEMORY:-${MEMORY}} ${JVM_OPTS}"

if [ $UID == 0 ]; then
  exec sudo -u bungeecord java $JVM_OPTS -jar $BUNGEE_JAR "$@"
else
  exec java $JVM_OPTS -jar $BUNGEE_JAR "$@"
fi
