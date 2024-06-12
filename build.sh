sudo apt install git-lfs
git lfs install
repo init --depth=1 -u https://github.com/ProjectSakura/android.git -b 14 --git-lfs
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b main .repo/local_manifests
/opt/crave/resync.sh
# Fixing fingerprint
rm -rf vendor/fingerprint/opensurce/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export SAKURA_BUILD_TYPE=gapps
export TARGET_SUPPORTS_64_BIT_APPS=true
export TARGET_BOOT_ANIMATION_RES=720
export SAKURA_MAINTAINER=Harsh-Tagra
source build/envsetup.sh
subject='/C=IN/ST=Haryana/L=Panipat/O=Android/OU=Android/CN=Android/emailAddress=harshtagra905@gmail.com'
for cert in media platform releasekey sdk_sandbox shared testkey verity; do \
    ./development/tools/make_key vendor/keys/$cert "$subject"; \
done
curl -o /vendor/keys/ https://raw.githubusercontent.com/sppidy/cravesign/main/keys.mk 
sudo apt-get install openssl

brunch lineage_ysl-ap1a-userdebug

