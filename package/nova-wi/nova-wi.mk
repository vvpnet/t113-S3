################################################################################
#
# nova-wi
#
################################################################################

NOVA_WI_SITE = ssh://git@github.com/Coxwain1987/t113_web_interface.git
NOVA_WI_SITE_METHOD = git
# device_01_app_v2.x
NOVA_WI_VERSION = 60c508a50c5a31c05bdd41b5c925ed8f9bb1046a

# install
define NOVA_WI_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/etc/nginx/nginx.conf $(TARGET_DIR)/etc/nginx/nginx.conf
	$(INSTALL) -D -m 0644 $(@D)/etc/nginx/fastcgi.conf $(TARGET_DIR)/etc/nginx/fastcgi.conf
	$(INSTALL) -D -m 0644 $(@D)/etc/nginx/.htpasswd $(TARGET_DIR)/etc/nginx/.htpasswd
	$(INSTALL) -D -m 0644 $(@D)/etc/nginx/fastcgi_params $(TARGET_DIR)/etc/nginx/fastcgi_params
	$(Q)cp -f -r -v $(@D)/var/www $(TARGET_DIR)/var/
	$(Q)git -C $(DL_DIR)/nova-wi/git/ describe --tags --always --dirty > $(TARGET_DIR)/var/www/version
endef

define NOVA_WI_PERMISSIONS
	/var/www r -1 www-data www-data  - - - - -
endef

define NOVA_WI_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(@D)/etc/init.d/S45wifi $(TARGET_DIR)/etc/init.d/S45wifi
	$(INSTALL) -D -m 0755 $(@D)/etc/init.d/S60fcgiwrap $(TARGET_DIR)/etc/init.d/S60fcgiwrap
endef

$(eval $(generic-package))
