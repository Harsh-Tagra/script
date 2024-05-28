sudo apt install git-lfs
git lfs install
repo init   -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
rm -rf vendor/gms
rm -rf .repo/projects/vendor/gms.git
rm -rf .repo/project-objects/*/android_vendor_gms.git 
rm -rf .repo/local_manifests/ 
# Clone RisingTechOSS 14
repo init  --depth 1 -u https://github.com/RisingTechOSS/android.git -b fourteen --git-lfs
# Clone local_manifests repository
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b main .repo/local_manifests
if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests https://github.com/Harsh-Tagra/local_manifests.git
 fi
# repo sync
/opt/crave/resync.sh
# Fixing fingerprint
rm -rf vendor/fingerprint/opensurce/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export RISING_MAINTAINER=harsh
export WITH_GMS=true
export TARGET_CORE_GMS=true
export TARGET_CORE_GMS_EXTRAS=true
source build/envsetup.sh
# build
riseup ysl userdebug
rise b
