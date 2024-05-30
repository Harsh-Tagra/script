#!/bin/bash
# Install git-lfs
sudo apt install -y git-lfs
git lfs install

# Initialize repo with RisingTechOSS android repository
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)

# Remove existing gms vendor directory and related repo projects
rm -rf vendor/gms
rm -rf .repo/projects/vendor/gms.git
rm -rf .repo/project-objects/*/android_vendor_gms.git
rm -rf .repo/local_manifests/

# Clone RisingTechOSS 14 repository with depth 1
repo init --depth=1 -u https://github.com/RisingTechOSS/android.git -b fourteen --git-lfs

# Clone local_manifests repository
git clone https://github.com/Harsh-Tagra/local_manifests.git --depth 1 -b main .repo/local_manifests

if [! 0 == 0 ]; then
    curl -o .repo/local_manifests https://github.com/Harsh-Tagra/local_manifests.git
fi

# Sync repo
/opt/crave/resync.sh

# Fixing fingerprint issue by cloning the required repository
rm -rf vendor/fingerprint/opensource/interfaces
git clone https://github.com/xiaomi-msm8953-devs/android_vendor_fingerprint_opensource_interfaces vendor/fingerprint/opensource/interfaces

# Set up build environment by cloning required repository
rm -rf vendor/rising/config/version.mk
git clone https://github.com/Harsh-Tagra/R.git --depth 1 -b main vendor/rising/config/

# Export environment variables for the build
export BUILD_USERNAME=harsh
export BUILD_HOSTNAME=crave
export RISING_MAINTAINER=Harsh-Tagra
export WITH_GMS=true
export TARGET_CORE_GMS=true


# Create and sign Android certificates if not exits 

    subject='/C=IN/ST=Haryana/L=Panipat View/O=harshtagra/OU=harshtagra/CN=harshtagra/emailAddress=harshtagra905@gmail.com'
    mkdir -p ~/.android-certs
    for cert in bluetooth cyngn-app media networkstack platform releasekey sdk_sandbox shared testcert testkey verity; do
        ./development/tools/make_key ~/.android-certs/$cert "$subject"
    done
    mkdir vendor/lineage-priv
   mv ~/.android-certs vendor/lineage-priv/keys
echo "PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/lineage-priv/keys/releasekey" > vendor/lineage-priv/keys/keys.mk

cat <<EOF > vendor/lineage-priv/keys/BUILD.bazel
filegroup(
    name = "android_certificate_directory",
    srcs = glob([
        "*.pk8",
        "*.pem",
    ]),
    visibility = ["//visibility:public"],
)


# Source the build environment setup script
source build/envsetup.sh

# Build the environment for ysl userdebug
riseup ysl userdebug

# Execute the build command
rise b
