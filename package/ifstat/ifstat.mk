################################################################################
#
# ifstat
#
################################################################################

IFSTAT_VERSION = 1.1
IFSTAT_SITE = http://gael.roualland.free.fr/ifstat
IFSTAT_LICENSE = GPL-2.0+
IFSTAT_LICENSE_FILES = COPYING

define IFSTAT_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_CONFIGURE_OPTS) ./configure
endef

define IFSTAT_BUILD_CMD
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IFSTAT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/ifstat $(TARGET_DIR)/usr/bin/if-stat
endef

$(eval $(generic-package))
