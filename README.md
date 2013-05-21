livecd
======

Run a livecd quickly and easily. Uses virtualbox for magic.

```bash
livecd start myos.iso

livecd list
# livecd-myos

livecd stop
```

You can also run multiple cds:

```bash
livecd start cd_a.iso
livecd start cd_a.iso
livecd start cd_b.iso

livecd list
# livecd-cd_a
# livecd-cd_a-1
# livecd-cd_b

livecd stop livecd-cd_a
# or stop all:
livecd stop
```
