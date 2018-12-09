#!/bin/sh

[[ -e ${MOUNT_PID_FILE} ]] || exit 1
/bin/rclone rc core/pid &> /dev/null || exit 1
