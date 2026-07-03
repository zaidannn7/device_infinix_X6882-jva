#!/bin/bash
rm -rf device/infinix/X6882-kernel

git clone --depth=1 https://github.com/javas-prjkt/device_infinix_X6882-kernel device/infinix/X6882-kernel

rm -rf hardware/mediatek device/mediatek/sepolicy_vndr
git clone --depth=1 -b sixteen-oem https://github.com/MillenniumOSS/android_vendor_mediatek_ims vendor/mediatek/ims
git clone --depth=1 https://github.com/zaidannn7/hardware_transsion hardware/transsion
git clone --depth=1 https://github.com/MillenniumOSS/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
git clone --depth=1 https://github.com/MillenniumOSS/android_hardware_mediatek hardware/mediatek
#git clone https://github.com/MillenniumOSS/android_device_millennium_common-kernel device/millennium/common-kernel
rm -rf packages/apps/ViPER4AndroidFX
rm -rf packages/Apps/ViPER4AndroidFX
git clone https://github.com/hound-lab/packages_apps_ViPER4AndroidFX packages/apps/ViPER4AndroidFX
RET=0
echo "- Applying Aperture Mediatek HFPS Mode"
cd packages/apps/Aperture
curl https://raw.githubusercontent.com/jvaswb/patches/refs/heads/sixteen/packages/apps/Aperture/0001-Aperture-Enable-MediaTek-HFPS-Mode-for-60-FPS-video-.patch | git am || {
  RET=$?
  git am --abort >/dev/null 2>&1
}
cd ../../../
echo "- Applying WPA3 Patch"
cd external/wpa_supplicant_8
curl https://raw.githubusercontent.com/jvaswb/patches/refs/heads/sixteen/external/wpa_supplicant_8/do_not_set_NL80211_WPA_VERSION_3.patch | git am || {
  RET=$?
  git am --abort >/dev/null 2>&1
}
cd ../../

if [ $RET -ne 0 ]; then
  echo "ERROR: Patch is not applied! Maybe it's already patched, or you'll have to adapt it to this specific rom source?"
else
  echo "OK: All patched"
fi

export BUILD_USERNAME=zaidanprjkt
export BUILD_HOSTNAME=android
