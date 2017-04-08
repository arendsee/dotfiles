# Installation disk

To build an  install stick, first download an ISO. This requires a torrent
handler, I currently use deluge.

``` sh
dd bs=4M if=/path/to/archlinux.iso of=/dev/sdX status=progress && sync
```
