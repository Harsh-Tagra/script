# Clone RisingTechOSS 14
repo init --depth 1 -u https://github.com/RisingTechOSS/android.git -b fourteen --git-lfs
# Clone local_manifests repository
git clone https://github.com/krishnaspeace/local_manifests.git --depth 1 -b main .repo/local_manifests
if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests https://github.com/krishnaspeace/local_manifests.git
 fi
# repo sync
/opt/crave/resync.sh
# Fixing fingerprint
rm -rf vendor/fingerprint/opensurce/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export RISING_MAINTAINER=Harsh Tagra
export WITH_GMS=true
export TARGET_CORE_GMS=true
export TARGET_DEFAULT_PIXEL_LAUNCHER=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
source build/envsetup.sh
# build
riseup ysl userdebug
rise b
