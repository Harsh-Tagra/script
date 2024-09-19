sudo apt install git-lfs
git lfs install
rm -rf .repo/local_manifests
repo init -u https://github.com/ProjectBlaze/manifest -b 15 --git-lfs

git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b main .repo/local_manifests
 /opt/crave/resync.sh
rm -rf vendor/fingerprint/opensurce/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export BLAZE_MAINTAINER=Harsh-Tagra
export WITH_GMS=false
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
source build/envsetup.sh
lunch lineage_ysl-ap3a-userdebug

# build
mka bacon
