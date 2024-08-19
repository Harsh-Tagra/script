sudo apt install git-lfs
git lfs install
repo init --depth=1 -u  https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
rm -rf .repo/local_manifests
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b crdroid .repo/local_manifests
/opt/crave/resync.sh
# Fixing fingerprint
 sudo rm -rf vendor/fingerprint/opensource/interfaces

git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave

source build/envsetup.sh
brunch lineage_ysl-ap2a-userdebug


