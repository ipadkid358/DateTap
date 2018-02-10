include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DateTapSpring DateTapKit
DateTapSpring_FILES = Spring.m
DateTapSpring_CFLAGS = -fobjc-arc

DateTapKit_FILES = Kit.xm
DateTapKit_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
