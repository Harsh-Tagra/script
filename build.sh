#!/bin/bash
# Install git-lfs
sudo apt install -y git-lfs
git lfs install
repo init   -u  https://github.com/ProjectBlaze/manifest -b 14-QPR2 --git-lfs
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
rm -rf hardware/xiaomi
rm -rf .repo/local_manifests/ 
# Clone RisingTechOSS 14 repository with depth 1
repo init --depth=1 -u https://github.com/ProjectBlaze/manifest -b 14-QPR2

# Clone local_manifests repository
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b main .repo/local_manifests

if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests  https://github.com/Harsh-Tagra/local_manifests.git
 fi

# Sync repo
/opt/crave/resync.sh

# Fixing fingerprint issue by cloning the required repository
rm -rf vendor/fingerprint/opensource/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces

# Set up build environment by cloning required repository


# Export environment variables for the build
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export BLAZE_MAINTAINER=Harsh-Tagra
export WITH_GMS=true
export TARGET_CORE_GMS=true



# Source the build environment setup script
source build/envsetup.sh

# Build the environment for ysl userdebug
lunch blaze_ysl-userdebug

# Execute the build command
make bacon
