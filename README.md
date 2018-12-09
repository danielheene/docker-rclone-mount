# docker-rclone-mount
Mount a __[rclone](https://github.com/ncw/rclone)__ remote inside a docker container.

### Start
```bash
docker run \
  --cap-add SYS_ADMIN \
  --device /dev/fuse \
  -v ${HOST_CONF_DIR}:/config \
  -v ${HOST_MOUNT_DIR}:/mount \
  danielheene/rclone-mount
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
