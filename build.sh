sudo apt install git-lfs
git lfs install
repo init --depth=1 -u https://github.com/CherishOS/android_manifest.git -b uqpr2 --git-lfs
rm -rf .repo/local_manifests
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b cherish .repo/local_manifests
/opt/crave/resync.sh
# Fixing fingerprint
sudo rm -rf vendor/fingerprint/opensource/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces

rm -rf hardware/qcom-caf/common
git clone https://github.com/LineageOS/android_hardware_qcom-caf_common hardware/qcom-caf/common
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export WITH_GMS=true
export TARGET_USES_PICO_GAPPS=true
subject='/C=IN/ST=Haryana/L=Panipat/O=Android/OU=Android/CN=Android/emailAddress=harshtagra905@gmail.com'
for x in releasekey platform shared media networkstack verity otakey testkey sdk_sandbox bluetooth; do \
  echo '' |./development/tools/make_key vendor/cherish/signing/keys/$x "$subject"; \
done
source build/envsetup.sh
brunch cherish_ysl-ap1a-userdebug
export WITH_GMS=false
export TARGET_USES_MINI_GAPPS=false
export CHERISH_VANILLA=true
source build/envsetup.sh
brunch cherish_ysl-ap1a-userdebug
