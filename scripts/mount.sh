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

# CHECK IF A CONFIG FILE IS PROVIDED
if [ -e ${CONFIG_DIR}/${CONFIG_FILE} ]; then
  echo "INFO: ${CONFIG_DIR}/${CONFIG_FILE} found - using config file!"
  CONFIG_PARAM="--config ${CONFIG_DIR}/${CONFIG_FILE}"
else
  echo "INFO: ${CONFIG_DIR}/${CONFIG_FILE} not found - using only globals!"
  CONFIG_PARAM=""
fi

# TODO: enhance logging handling
# TODO: disable --rc for only checking status, try via "rclone about remote:"
# MOUNT REMOTE TO MOUNT DIRECTORY
/bin/rclone ${CONFIG_PARAM} mount ${MOUNT_NAME}: ${MOUNT_DIR} --allow-non-empty --allow-other --uid ${UID} --gid ${GID} --rc &
PID=${!}
echo ${PID} > ${MOUNT_PID_FILE}

wait ${PID}
exit $?
