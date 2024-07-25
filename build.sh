# Clone Evolution X 
sudo apt-get install llvm
sudo apt-get install lld
sudo apt-get install python2
sudo apt-get install python3

rm -rf .repo/local_manifests/
repo init -u https://github.com/Evolution-XYZ/manifest -b udc --git-lfs
# Clone local_manifests repository

git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b evo .repo/local_manifests

# repo sync
/opt/crave/resync.sh

rm -rf vendor/fingerprint/opensurce/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave

source build/envsetup.sh
# build
lunch lineage_ysl-userdebug


m evolution
