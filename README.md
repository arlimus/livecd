livecd
======
[![Gem Version](https://badge.fury.io/rb/livecd.png)](http://badge.fury.io/rb/livecd)
[![Build Status](https://travis-ci.org/arlimus/livecd.png)](https://travis-ci.org/arlimus/livecd)

Run a livecd quickly and easily. Uses virtualbox for magic.

installation
------------

    gem install livecd

usage
-----

```bash
livecd start myos.iso

livecd list
# myos

livecd stop
```

Quickstart:

```bash
# download damn small linux (http://www.damnsmalllinux.org/)
wget http://distro.ibiblio.org/damnsmall/release_candidate/dsl-4.11.rc2.iso
livecd start --memory 512 dsl-4.11.rc2.iso
```

Configure the memory. The default is 128 MB, but you can change it.

```bash
livecd --memory 512 myos.iso
```

Run multiple livecds at the same time:

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

kudos / contributions
---------------------

* chris-rock
