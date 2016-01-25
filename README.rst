===================
Lighthouse firmware
===================

This repository contains open-source build scripts and closed-source binary
blobs for building a `Lighthouse <https://outernet.is/lighthouse/>`_ image.
Compiling the sources using this build system should result in an image
identical to the one that is found on the Lighthouses.

This repository supersedes the [Lighthouse firmware 
repository](https://github.com/Outernet-Project/lighthouse-firmware) used to
build the Lighthouse images. 

License
=======

The complete code for the build system is released under GPLv3. See the COPYING
file in the source tree for more information.

The ONDD binary located in the ``rootfs/rootfs_overlay/usr/sbin`` directory is
released under a different proprietary license. Please see ONDD_LICENSE in the
source tree for more information.

Requirements
============

You will need a Linux system to build the image.

The following should be installed on the build box:

- build tools gcc, make, etc
- util-linux
- git
- hg (mercurial)
- libstdc++6 32-bit (on 64-bit systems)

Note that the build may require as much as 40GB of free storage space to
complete, and more than 4GB of RAM.

Depending on your machine's CPU and RAM speed, the build may take anywhere from
40 minutes to over 4 hours.

Cloning the repository
======================
::
    $ git clone --recursive https://github.com/Outernet-Project/outerbox.git
    

Building
========

To build the rootfs, run make with default target::

    $ make

The image file in .pkg format will be available in ``images`` directory when
the build is finished. Note that this file is not signed. Outernet will **not**
provide the signing keys to 3rd parties.

Rebuilding after changes to rootfs overlay
==========================================

When modifying files in the rootfs overlay, use the following command to
rebuild::

    $ make rebuild

Modifying the build
===================

Before you can modify the build, you should become familiar with `Buildroot
<https://buildroot.org/docs.html>`_.

The build can be modified by adding new packages, and editing files in the
roofs overlay. The bring up the build configuration menu, use the following
command::

    $ make menuconfig

Note that when changing the options in the build configuration menu, the
configuration is saved in a temporary directory (``rootfs/output/.config``).
This gets removed when running ``make clean``. To make the change more
permanent, run ``make savedefconfig``.

To change the Linux kernel configuration you can run::

    $ make linux-menuconfig

Similarly, to change the Busybox configuration::

    $ make busybox-menuconfig

To have all configurations, run::

    $ make saveconfig

When you are happy with the changes, run::

    $ make

Posting questions about the build
=================================

If you get stuck during the build, it's helpful to show the build log. You can
save the build log messages to a file like so::

    $ make 2>&1 | tee build.log

Differences to the old build system
===================================

The structure of the build is made similar to
`ORx firmware build <https://github.com/Outernet-Project/orx-rpi>`_ and the
toolchain is now the buildroot's built-in toolchain rather than the external
crosstool-ng one.

The major difference in terms of workflow is that all modifications are
contained within this single repository as opposed to using multiple submodules
as in the previous build. You will find the configuration files in
``rootfs/config`` directory, and the rootfs overlay in the
``rootfs/rootfs_overlay`` directory.

