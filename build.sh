sudo apt install git-lfs
git lfs install
repo init -u https://github.com/RisingTechOSS/android -b fifteen --git-lfs
rm -rf .repo/local_manifests
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b rise .repo/local_manifests
/opt/crave/resync.sh
# Fixing fingerprint
 sudo rm -rf vendor/fingerprint/opensource/interfaces

git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
sudo rm -rf vendor/risingOTA/risingOS.devices
wget https://raw.githubusercontent.com/Harsh-Tagra/script/rise/risingOS.devices -P vendor/risingOTA/
sudo rm -rf packages/apps/Updater/app/src/main/res/values/strings.xml
wget https://raw.githubusercontent.com/Harsh-Tagra/script/rise/strings.xml -P packages/apps/Updater/app/src/main/res/values/
sudo rm -rf vendor/rising/prebuilts/prebuilts.mk
wget https://raw.githubusercontent.com/Harsh-Tagra/script/rise/prebuilts.mk -P vendor/rising/prebuilts
sudo rm -rf packages/apps/crDroidSettings/res/values/cr_arrays.xml
wget https://raw.githubusercontent.com/Harsh-Tagra/script/rise/cr_arrays.xml -P packages/apps/crDroidSettings/res/values/
git clone https://github.com/Harsh-Tagra/rom-keys.git /tmp/rom-keys
sudo mv /tmp/rom-keys/rise-priv/ /tmp/src/android/vendor/lineage-priv
sudo rm -rf /tmp/rom-keys
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
rm -rf device/xiaomi/ysl/lineage_ysl.mk
wget https://raw.githubusercontent.com/Harsh-Tagra/script/rise/lineage_ysl.mk  -p device/xiaomi/ysl

source build/envsetup.sh

riseup ysl userdebug
rise b && rm -rf /vendor/lineage-priv
