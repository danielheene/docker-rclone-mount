# docker-rclone-mount
Mount a rclone remote inside a docker container.

### Start
```bash
docker run \
  --cap-add SYS_ADMIN \
  --device /dev/fuse \
  -v ${HOST_CONF_DIR}:/config \
  -v ${HOST_MOUNT_DIR}:/mount \
  rclone-mount
```

### Environment variables

```
CONFIG_DIR      /config         # directory where config file is stored
CONFIG_FILE     rclone.conf     # name of the stored rclone config file
MOUNT_DIR       /mount          # directory where the volume is mounted
MOUNT_REMOTE    mount           # rclone volume name which will be mounted
CACHE_DIR       /cache          # directory which rclone uses for caching
```

### Example config file
```
[remote]
type = drive
...

[cache]
type = cache
remote = remote:
tmp_upload_path = /cache
...

[mount]
type = alias
remote = cache:
...
```

----
## License
[MIT](LICENSE)
