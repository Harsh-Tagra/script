sudo apt install git-lfs
git lfs install
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
rm -rf .repo/local_manifests
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b rise .repo/local_manifests
/opt/crave/resync.sh
# Fixing fingerprint
 sudo rm -rf vendor/fingerprint/opensource/interfaces

git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
git clone https://github.com/Harsh-Tagra/rom-keys.git /tmp/rom-keys
sudo mv /tmp/rom-keys/crdroid-priv/ /tmp/src/android/vendor/lineage-priv
sudo rm -rf /tmp/rom-keys
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
source build/envsetup.sh

riseup ysl userdebug
rise sb && rm -rf /vendor/lineage-priv
