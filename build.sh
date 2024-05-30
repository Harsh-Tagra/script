#!/bin/bash
sign=~/.android-certs/.certs_generated
# Install git-lfs
sudo apt install -y git-lfs
git lfs install

# Initialize repo with RisingTechOSS android repository
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

# Remove existing gms vendor directory and related repo projects
rm -rf vendor/gms
rm -rf .repo/projects/vendor/gms.git
rm -rf .repo/project-objects/*/android_vendor_gms.git
rm -rf .repo/local_manifests/

# Clone RisingTechOSS 14 repository with depth 1
repo init --depth=1 -u https://github.com/RisingTechOSS/android.git -b fourteen --git-lfs

# Clone local_manifests repository
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b main .repo/local_manifests

# Check if local_manifests directory is empty and fetch if so
if [ ! -d ".repo/local_manifests" ] || [ -z "$(ls -A .repo/local_manifests)" ]; then
    curl -o .repo/local_manifests https://github.com/Harsh-Tagra/local_manifests.git
fi

# Sync repo
/opt/crave/resync.sh

# Fixing fingerprint issue by cloning the required repository
rm -rf vendor/fingerprint/opensource/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces

# Set up build environment by cloning required repository
rm -rf vendor/rising/config/version.mk
git clone https://github.com/Harsh-Tagra/R.git --depth 1 -b main vendor/rising/config/

# Export environment variables for the build
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export RISING_MAINTAINER=Harsh-Tagra
export WITH_GMS=true
export TARGET_CORE_GMS=true


# Create and sign Android certificates if not exits 
if [ ! -f "$sign"  ]; then
    subject='/C=IN/ST=Haryana/L=Panipat View/O=harshtagra/OU=harshtagra/CN=harshtagra/emailAddress=harshtagra905@gmail.com'
  mkdir ~/.android-certs
for cert in bluetooth cyngn-app media networkstack platform releasekey sdk_sandbox shared testcert testkey verity; do \
    ./development/tools/make_key ~/.android-certs/$cert "$subject"; \
done
cp ./development/tools/make_key ~/.android-certs/
sed -i 's|2048|4096|g' ~/.android-certs/make_key
for apex in com.android.adbd com.android.adservices com.android.adservices.api com.android.appsearch com.android.art com.android.bluetooth com.android.btservices com.android.cellbroadcast com.android.compos com.android.configinfrastructure com.android.connectivity.resources com.android.conscrypt com.android.devicelock com.android.extservices com.android.graphics.pdf com.android.hardware.biometrics.face.virtual com.android.hardware.biometrics.fingerprint.virtual com.android.hardware.boot com.android.hardware.cas com.android.hardware.wifi com.android.healthfitness com.android.hotspot2.osulogin com.android.i18n com.android.ipsec com.android.media com.android.media.swcodec com.android.mediaprovider com.android.nearby.halfsheet com.android.networkstack.tethering com.android.neuralnetworks com.android.ondevicepersonalization com.android.os.statsd com.android.permission com.android.resolv com.android.rkpd com.android.runtime com.android.safetycenter.resources com.android.scheduling com.android.sdkext com.android.support.apexer com.android.telephony com.android.telephonymodules com.android.tethering com.android.tzdata com.android.uwb com.android.uwb.resources com.android.virt com.android.vndk.current com.android.vndk.current.on_vendor com.android.wifi com.android.wifi.dialog com.android.wifi.resources com.google.pixel.camera.hal com.google.pixel.vibrator.hal com.qorvo.uwb; do \
    subject='/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN='$apex'/emailAddress=android@android.com'; \
    ~/.android-certs/make_key ~/.android-certs/$apex "$subject"; \
    openssl pkcs8 -in ~/.android-certs/$apex.pk8 -inform DER -out ~/.android-certs/$apex.pem; \
done
mka target-files-package otatools
curl -O https://raw.githubusercontent.com/ObsidianMaximus/scripts/master/signing/Sign.sh
bash Sign.sh
fi

# Source the build environment setup script
source build/envsetup.sh

# Build the environment for ysl userdebug
riseup ysl userdebug

# Execute the build command
rise b
