sudo apt install git-lfs
git lfs install
 rm -rf .repo/local_manifests
 repo init --depth=1 -u  https://github.com/ProjectSakura/android.git -b 14 --git-lfs
 rm -rf .repo/local_manifests
 git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b ProjectSakura .repo/local_manifests
/opt/crave/resync.sh
# Fixing fingerprint
 sudo rm -rf vendor/fingerprint/opensource/interfaces

git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces

git clone https://github.com/Harsh-Tagra/rom-keys.git /tmp/rom-keys
sudo mv /tmp/rom-keys/sakura-priv /tmp/src/android/vendor
sudo rm -rf /tmp/rom-keys

export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export SAKURA_BUILD_TYPE=gapps
source build/envsetup.sh
brunch lineage_ysl-ap2a-userdebug && rm -rf /vendor/sakura-priv


