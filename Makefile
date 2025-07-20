TARGET = iphone:clang:latest:16.0
INSTALL_TARGET_PROCESSES = WeSpy

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = WeSpy

WeSpy_FILES = ContentView.swift WeSpyApp.swift SplashView.swift KeywordManager.swift KeywordManagementView.swift

include $(THEOS_MAKE_PATH)/application.mk
