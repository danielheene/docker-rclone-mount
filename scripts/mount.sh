#!/bin/sh

PID=null
UID=${UID}
GID=${GID}

# TERMINATE MOUNT AND CLEAN UP
function _terminate {
  kill $(cat ${MOUNT_PID_FILE}) && \
  umount ${MOUNT_DIR} || true && \
  rm ${MOUNT_PID_FILE} &> /dev/null
  exit $?
}

# TRAP SIGNALS TO RUN TERMINATE FUNCTION
trap _terminate SIGHUP SIGINT SIGTERM SIGQUIT SIGABRT

# OUTPUT ERROR MESSAGE IF NO CONFIG FILE EXISTS
[[ -e ${CONFIG_DIR}/${CONFIG_FILE} ]] || { echo "ERROR: ${CONFIG_DIR}/${CONFIG_FILE} does not exist!" 1>&2; exit 1; }

# MOUNT REMOTE TO MOUNT DIRECTORY
/bin/rclone --config ${CONFIG_DIR}/${CONFIG_FILE} mount ${MOUNT_NAME}: ${MOUNT_DIR} $@ --allow-non-empty --allow-other --uid ${UID} --gid ${GID} --rc -v &
PID=${!}
echo ${PID} > ${MOUNT_PID_FILE}

wait ${PID}
exit $?
