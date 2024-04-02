################################################################################
#
# nova-wi
#
################################################################################

NOVA_WI_SITE = ssh://git@github.com/Coxwain1987/t113_web_interface.git
NOVA_WI_SITE_METHOD = git
NOVA_WI_VERSION = v1.0.1

# install
define NOVA_WI_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(@D)/etc $(TARGET_DIR)/etc
	$(INSTALL) -d $(@D)/var/www $(TARGET_DIR)/var/www
endef

$(eval $(generic-package))
