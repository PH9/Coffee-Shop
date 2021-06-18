XCODEBUILD := xcodebuild
BUILD_FLAGS = -scheme $(SCHEME) -destination $(DESTINATION)

SCHEME ?= 'Coffee Shop'
PLATFORM ?= iOS
IOS_VERSION ?= latest
IPHONE_NAME ?= iPhone 8

ifeq ($(PLATFORM),iOS)
	DESTINATION ?= 'platform=iOS Simulator,name=$(IPHONE_NAME),OS=$(IOS_VERSION)'
endif

XCPRETTY :=
ifneq ($(shell type -p xcpretty),)
	XCPRETTY += | xcpretty -c && exit $${PIPESTATUS[0]}
endif

install-brew:
	brew update
	brew bundle

setup-pre-commit:
	pre-commit install
	pre-commit install --hook-type commit-msg

setup: install-brew setup-pre-commit

test:
	$(XCODEBUILD) test $(BUILD_FLAGS) $(XCPRETTY)
