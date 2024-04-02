################################################################################
#
# novawi
#
################################################################################

NOVAWI_VERSION = 5d1ac0736c6de2c46c33b3bbdf46d0df86645fe9
NOVAWI_SITE = $(call github,Coxwain1987,t113_web_interface,$(NOVAWI_VERSION))

# install
# define T113WI_INSTALL_TARGET_CMDS
# 	$(INSTALL) -m 0644 -D $(@D)/* \
# 		$(TARGET_DIR)/*
# endef

$(eval $(generic-package))
