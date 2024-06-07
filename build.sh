# Clone Evolution X 
rm -rf .repo/local_manifests/
repo init --depth 1 -u https://github.com/Evolution-X/manifest -b u --git-lfs
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
source build/envsetup.sh
# build
lunch evolution_ysl-userdebug
m evolution
