#!/bin/bash

for WORLD in world world_nether world_the_end; do
  if [ ! -f ${SPIGOT_DIR}/${WORLD}/level.dat ]; then
    echo "Empty ${WORLD}! Restoring!"
    cp -r ${SPIGOT_DIR}/backups/${WORLD}/* ${SPIGOT_DIR}/${WORLD}/
  fi
done

exec java $JVM_OPTS -Dcom.mojang.eula.agree=true -jar /minecraft/spigot.jar "${SPIGOT_OPTS}"
