################################################################################
#
# ply
#
################################################################################

<<<<<<< HEAD
PLY_VERSION = 2.2.0
=======
PLY_VERSION = 2.1.1
<<<<<<< HEAD
>>>>>>> pakage: add target package ply
PLY_SITE = $(call github,wkz,ply,$(PLY_VERSION))
PLY_AUTORECONF = YES
PLY_LICENSE = GPL-2.0
PLY_LICENSE_FILES = COPYING
PLY_INSTALL_STAGING = YES
PLY_DEPENDENCIES = host-flex host-bison
=======
PLY_SITE = https://github.com/wkz/ply/releases/download/$(PLY_VERSION)
# fetched from Github, with no configure script
PLY_AUTORECONF = YES
PLY_DEPENDENCIES = host-bison host-flex
PLY_LICENSE = GPL-2.0+
PLY_LICENSE_FILES = COPYING
>>>>>>> pakage: add target package ply

$(eval $(autotools-package))
