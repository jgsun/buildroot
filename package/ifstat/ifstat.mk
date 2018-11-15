################################################################################
#
# ifstat
#
################################################################################

IFSTAT_VERSION = 1.1
IFSTAT_SITE = http://gael.roualland.free.fr/ifstat
# IFSTAT_DEPENDENCIES = ncurses libpcap
IFSTAT_LICENSE = GPL-2.0+
IFSTAT_LICENSE_FILES = COPYING

# IFSTAT_LIBS = -lpcap
# ifeq ($(BR2_STATIC_LIBS),y)
# IFSTAT_LIBS += `$(STAGING_DIR)/usr/bin/pcap-config --static --additional-libs`
# endif
# IFSTAT_CONF_ENV += LIBS+="$(IFSTAT_LIBS)"

define IFSTAT_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_CONFIGURE_OPTS) ./configure
endef

define IFSTAT_BUILD_CMD
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IFSTAT_INSTALL_TARGET_CMDS
#	$(TARGET_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install
	$(INSTALL) -m 0755 -D $(@D)/ifstat $(TARGET_DIR)/usr/bin/if-stat
endef

$(eval $(generic-package))
