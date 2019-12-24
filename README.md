# chrisbensch/sifter

Docker container of SANS Investigative Forensic Toolkit (SIFT) Workstation Version (latest) 

Image is based on the [ubuntu](https://registry.hub.docker.com/u/ubuntu/) base image


## Docker image usage

```
docker run -it chrisbensch/sifter /bin/bash
```

## Examples

Mount host images to /data and run shell inside container:

```
docker run -v /path/to/host/raw/images:/data:rw chrisbensch/sifter -it chrisbensch/sifter /bin/bash
```



