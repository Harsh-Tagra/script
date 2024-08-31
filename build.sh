sudo apt install git-lfs
git lfs install
repo init --depth=1 -u  https://github.com/ProjectSakura/android.git -b 14 --git-lfs
rm -rf .repo/local_manifests
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b ProjectSakura .repo/local_manifests
rm -rf prebuilts/clang/host/linux-x86
/opt/crave/resync.sh
# Fixing fingerprint
 sudo rm -rf vendor/fingerprint/opensource/interfaces

git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export SAKURA_BUILD_TYPE=gapps
source build/envsetup.sh
grep -ir --exclude-dir=out -e '^((?!(?i)readme\.md).)*$' "(?i)abcdef" .
brunch lineage_ysl-ap2a-userdebug

