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
if [ -n "$subject" ]; then
export subject='/C=IN/ST=Haryana/L=Panipat View/O=harshtagra/OU=harshtagra/CN=harshtagra/emailAddress=harshtagra905@gmail.com'
mkdir ~/.android-certs
for cert in bluetooth cyngn-app media networkstack platform releasekey sdk_sandbox shared testcert testkey verity; do \
    ./development/tools/make_key ~/.android-certs/$cert "$subject"; \
done
cp ./development/tools/make_key ~/.android-certs/
sed -i 's|2048|4096|g' ~/.android-certs/make_key
for apex in com.android.adbd com.android.adservices com.android.adservices.api com.android.appsearch com.android.art com.android.bluetooth com.android.btservices com.android.cellbroadcast com.android.compos com.android.configinfrastructure com.android.connectivity.resources com.android.conscrypt com.android.devicelock com.android.extservices com.android.graphics.pdf com.android.hardware.biometrics.face.virtual com.android.hardware.biometrics.fingerprint.virtual com.android.hardware.boot com.android.hardware.cas com.android.hardware.wifi com.android.healthfitness com.android.hotspot2.osulogin com.android.i18n com.android.ipsec com.android.media com.android.media.swcodec com.android.mediaprovider com.android.nearby.halfsheet com.android.networkstack.tethering com.android.neuralnetworks com.android.ondevicepersonalization com.android.os.statsd com.android.permission com.android.resolv com.android.rkpd com.android.runtime com.android.safetycenter.resources com.android.scheduling com.android.sdkext com.android.support.apexer com.android.telephony com.android.telephonymodules com.android.tethering com.android.tzdata com.android.uwb com.android.uwb.resources com.android.virt com.android.vndk.current com.android.vndk.current.on_vendor com.android.wifi com.android.wifi.dialog com.android.wifi.resources com.google.pixel.camera.hal com.google.pixel.vibrator.hal com.qorvo.uwb; do \
   ~/.android-certs/make_key ~/.android-certs/$apex "$subject"; \
    openssl pkcs8 -in ~/.android-certs/$apex.pk8 -inform DER -out ~/.android-certs/$apex.pem; \
done
fi 
source build/envsetup.sh
# build
riseup ysl userdebug
curl -O https://raw.githubusercontent.com/ObsidianMaximus/scripts/master/signing/Sign.sh
bash Sign.sh
rise b
