# docker-rclone-mount
Mount a __[rclone](https://github.com/ncw/rclone)__ remote inside a docker container.

### Start Example
__mounting a remote providing its config via file__
```bash
docker run \
  --cap-add SYS_ADMIN \
  --device /dev/fuse \
  -v /example/config/path:/config \
  -v /example/mount/path:/mount \
  danielheene/rclone-mount
```

__mounting a remote providing its config via [environment variables](https://rclone.org/docs/#environment-variables)__
```bash
docker run \
  --cap-add SYS_ADMIN \
  --device /dev/fuse \
  -e "RCLONE_STATS=5s" \
  -e "RCLONE_CONFIG_MOUNT_TYPE=drive" \
  danielheene/rclone-mount
```

__It's also possible to combine both ways! Like only passing you tokens or password via the environment variables.__
### Environment Defaults
```
CACHE_DIR       /cache                        # directory which rclone uses for caching
CONFIG_DIR      /config                       # directory where config file is stored
CONFIG_FILE     rclone.conf                   # name of the stored rclone config file
LOG_DIR         /logs                         
LOG_FILE        /rclone.log
LOG_LEVEL       NOTICE
MOUNT_DIR       /mount                        # directory where the volume is mounted
MOUNT_NAME      mount                         # rclone volume name which will be mounted
MOUNT_PID_FILE  /var/run/rclone-mount.pid
UID             1000
GID             1000
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
```
MIT License

Copyright (c) 2018 Daniel Heene

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
