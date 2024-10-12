# Clone Evolution X 

rm -rf .repo/local_manifests/

repo init -u https://github.com/LineageOS/android -b lineage-22.0 --git-lfs
# Clone local_manifests repository

git clone https://github.com/Harsh-Tagra/local_manifests.git -b evo --depth 1  .repo/local_manifests

# repo sync
/opt/crave/resync.sh

rm -rf vendor/fingerprint/opensurce/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
source build/envsetup.sh
# build
unch lineage_ysl_apa1-userdebug



