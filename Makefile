
include $(MAKE_INCLUDE_GEN)

.PHONY: all combine clean


#*****************************************************************************#
#                            OBJECT FILE LIST                                 #
#*****************************************************************************#
OBJS =

#*****************************************************************************#
#                        RULES TO GENERATE TARGETS                            #
#*****************************************************************************#

# Define the Rules to build the core targets
all: combine clean

combine:
	@if [ ! -f asdk/asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz ]; then \
		echo "Combining tar.gz files..."; \
		cat asdk/asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz.* > asdk/asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz; \
		echo "Combining completed."; \
	else \
		echo "File asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz already exists. Skipping combination."; \
	fi

ifneq ($(CONFIG_TOOLCHAIN_ARM_GCC), y)
ifeq ($(COMPILEOS),$(LINUX_OS))
	$(MKDIR) -p linux
	tar -jxvf asdk/asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz -C linux/

	#LZM for GCC Server build & Cygwin Download
	#$(MKDIR) -p cygwin
	#tar -jxvf asdk/asdk-4.9.3-m4-EL-rtos-n2.1-a16ft-150617-cygwin.tar.bz2 -C cygwin/
else ifeq ($(COMPILEOS_CYGWIN),Cygwin)
	$(MKDIR) -p cygwin
	tar -jxvf asdk/asdk-6.4.1-cygwin-newlib-build-2778-i686.tar.bz2 -C cygwin/
else ifeq ($(COMPILEOS),$(DARWIN_OS))
	$(MKDIR) -p darwin
ifeq ($(shell uname -m),x86_64)
	tar -jxvf $(KM4_BUILDDIR)/toolchain/asdk/asdk-6.5.0-darwin-newlib-build-3078-x86_64.tar.bz2 -C darwin/
#arm64
else
	tar -jxvf $(KM4_BUILDDIR)/toolchain/asdk/asdk-10.4.1-darwin-newlib-build-3779-arm64.tar.bz2 -C darwin/
endif
endif

else
	$(MKDIR) -p cygwin
	tar -zxvf ../../../tools/arm-none-eabi-gcc/4.8.3-2014q1.tar.gz -C cygwin/
endif

clean:
	@echo "Cleaning up..."
	@if [ -f asdk/asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz ]; then \
		rm asdk/asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz; \
		echo "Deleted asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz"; \
	else \
		echo "File asdk-6.4.1-linux-newlib-build-2773-i686.tar.gz does not exist."; \
	fi

#*****************************************************************************#
#                          GENERATE OBJECT FILES                              #
#*****************************************************************************#
CORE_TARGETS: $(OBJS)

