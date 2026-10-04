Assumes that the hostname is "WORKER01":

## Build

```sh
GUIX_MACHINE=WORKER01 \
guix system -L modules build config.scm
```

## Install

```sh
GUIX_MACHINE=WORKER01 \
guix system -L modules init config.scm /mnt
```

## Reconfigure

```sh
GUIX_MACHINE=WORKER01 \
guix system -L modules reconfigure config.scm
```

## Update channels

```sh
guix pull -C channels.scm
```