include $(sort $(wildcard $(BR2_EXTERNAL)/package/*/*.mk))

ifeq ($(BR2_OUTERBOX_VERSIONLESS_PKG),y)
BR2_OUTERBOX_VERSION=n
else
BR2_OUTERBOX_VERSION=y
endif

# Build all post-* script args here because otherwise we have no access to
# variables set in the configuration step.
BR2_ROOTFS_POST_SCRIPT_ARGS = $(BR2_LINUX_KERNEL_CUSTOM_REPO_VERSION) \
							  $(BR2_OUTERBOX_VERSION) \
							  $(BR2_OUTERBOX_TMPFS_SIZE) \
							  $(BR2_OUTERBOX_SIGNATURE_FILE)
