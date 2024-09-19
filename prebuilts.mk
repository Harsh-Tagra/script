#
# Copyright (C) 2023 The risingOS Android Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_SOONG_NAMESPACES += \
    vendor/rising/prebuilts

# Overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/rising/overlays

PRODUCT_PACKAGES += \
    DeviceIntelligenceNetworkPrebuilt-v.U.14.playstore \
    SettingsIntelligenceGooglePrebuilt  \
    PrebuiltDeskClockGoogle \
    CalculatorGooglePrebuilt \
    MarkupGoogle
    
TARGET_PREBUILT_GOOGLE_CAMERA ?= false
ifeq ($(strip $(TARGET_PREBUILT_GOOGLE_CAMERA)),true)
PRODUCT_PACKAGES += \
    GoogleCamera
endif
TARGET_DEFAULT_PIXEL_LAUNCHER ?= false
ifeq ($(strip $(TARGET_DEFAULT_PIXEL_LAUNCHER)),true)
PRODUCT_PACKAGES += \
    NexusLauncherRelease
endif

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
ifneq ($(filter $(CURRENT_DEVICE), cheetah husky panther shiba lynx akita),)
TARGET_ASI := ASI_2022
PRODUCT_PACKAGES += \
    DevicePersonalizationPixel2022
else
TARGET_ASI := ASI_2020
PRODUCT_PACKAGES += \
    DevicePersonalizationPixel2020
endif

ifneq ($(filter $(CURRENT_DEVICE), husky shiba akita),)
PRODUCT_PACKAGES += \
    HealthIntelligenceStubPrebuilt
endif

PRODUCT_COPY_FILES += \
    vendor/rising/prebuilts/bootanimation/bootanimation_rising.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation_rising.zip \
    vendor/rising/prebuilts/bootanimation/bootanimation_valorant.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation_valorant.zip \
    vendor/rising/prebuilts/bootanimation/bootanimation_google.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation_google.zip \
    vendor/rising/prebuilts/bootanimation/bootanimation_google_monet.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation_google_monet.zip
