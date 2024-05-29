sudo apt install git-lfs
git lfs install
repo init   -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
rm -rf vendor/gms
rm -rf .repo/projects/vendor/gms.git
rm -rf .repo/project-objects/*/android_vendor_gms.git 
rm -rf .repo/local_manifests/ 
# Clone RisingTechOSS 14
repo init  --depth 1 -u https://github.com/RisingTechOSS/android.git -b fourteen --git-lfs
# Clone local_manifests repository
git clone https://github.com/krishnaspeace/local_manifests.git --depth 1 -b main .repo/local_manifests
if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests https://github.com/krishnaspeace/local_manifests.git
 fi
# repo sync
/opt/crave/resync.sh
# Fixing fingerprint
rm -rf vendor/fingerprint/opensurce/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces
# Set up build environment
rm -rf  vendor/rising/config/version.mk
git clone https://github.com/Harsh-Tagra/R.git  --depth 1 -b main  vendor/rising/config/
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export RISING_MAINTAINER=Harsh-Tagra
export WITH_GMS=true
export TARGET_CORE_GMS=true

subject='/C=IN/ST=Haryana/L=Panipat View/O=harshtagra/OU=harshtagra/CN=harshtagra/emailAddress=harshtagra905@gmail.com'
mkdir ~/.android-certs
for cert in bluetooth cyngn-app media networkstack platform releasekey sdk_sandbox shared testcert testkey verity; do \
    ./development/tools/make_key ~/.android-certs/$cert "$subject"; \
done
cp ./development/tools/make_key ~/.android-certs/
sed -i 's|2048|4096|g' ~/.android-certs/make_key
curl -O https://raw.githubusercontent.com/ObsidianMaximus/scripts/master/signing/Generate_Keys.sh
bash Generate_Keys.sh
source build/envsetup.sh
# build
riseup ysl userdebug
curl -O https://raw.githubusercontent.com/ObsidianMaximus/scripts/master/signing/Sign.sh
bash Sign.sh
rise b
