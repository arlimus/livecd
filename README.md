livecd
======

Run a livecd quickly and easily. Uses virtualbox for magic.

```bash
livecd start myos.iso

livecd list
# myos

livecd stop
```

You can also run multiple cds:

```bash
livecd start cd_a.iso
livecd start cd_a.iso
livecd start cd_b.iso

livecd list
# cd_a
# cd_a-1
# cd_b

livecd stop cd_a
# or stop all:
livecd stop
```
