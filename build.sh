sudo apt install git-lfs
git lfs install
rm -rf .repo/local_manifests
repo init --depth=1 -u https://github.com/ProjectBlaze/manifest -b 14-QPR2 --git-lfs

git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b main .repo/local_manifests
if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests https://github.com/Harsh-Tagra/local_manifests.git
 fi
 /opt/crave/resync.sh
# repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
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

# build
mka bacon
