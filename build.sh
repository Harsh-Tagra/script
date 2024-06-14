sudo apt install git-lfs
git lfs install
repo init --depth=1 -u https://github.com/ProjectSakura/android.git -b 14 --git-lfs

git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b main .repo/local_manifests
if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests https://github.com/Harsh-Tagra/local_manifests.git
 fi
/opt/crave/resync.sh
# Fixing fingerprint
rm -rf vendor/fingerprint/opensurce/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export BLAZE_MAINTAINER=Harsh-Tagra
export WITH_GMS=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
source build/envsetup.sh
lunch lineage_ysl-ap1a-userdebug
mka target-files-package otatools
/opt/crave/crave_sign.sh
# build
mka bacon
