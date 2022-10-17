#!/bin/bash

ask() {
echo " "
echo "Please choose your destination:"
echo "1) Normal android system"
echo "2) Recovery"

read -N 1 REPLY
echo " "
}


#check for arguments
case $1 in
        [12])
                REPLY="$1";;
        *)
		ask;;
esac

case $REPLY in
	[1]) echo "Running install for normal android system";;
	[2]) echo "Running install for recovery";;
	*)   echo ""; echo -e "\033[1;31mThis is not a valid option!\033[0m"; exit 0;;
esac

BASE_PATH=""
TARGET=1


if [ $REPLY -eq 1 ]; then
  # Get root and mount with root privs
  adb root
  adb remount
else
  echo "Reboot recovery to switch slots after applying update via adb sideload."
  echo "Mount system and enable ADB from recoverys advanced menu"
  read -p "To cancel press CRTL+c NOW"
  adb shell mount -o remount,rw /mnt/system
  BASE_PATH="/mnt/system"
  TARGET=2
fi

# Install AuroraServices
adb push auroraservices/AuroraServices.apk $BASE_PATH/system/priv-app/
adb push auroraservices/com.aurora.services.xml $BASE_PATH/system/etc/permissions/

# Replace Fakestore with play store
adb shell rm -rf $BASE_PATH/system/priv-app/FakeStore
adb shell mkdir $BASE_PATH/system/priv-app/Phonesky
adb push phonesky/Phonesky.apk $BASE_PATH/system/priv-app/Phonesky/
adb push files/permissions-com.android.vending.xml $BASE_PATH/system/etc/permissions/

# Install aa, gapps & speech service stubs
adb shell mkdir $BASE_PATH/system/priv-app/AndroidAuto
adb push androidauto/AndroidAuto/AndroidAutoStubPrebuilt.apk $BASE_PATH/system/priv-app/AndroidAuto/
adb push files/privapp-permissions-com.google.android.projection.gearhead.xml $BASE_PATH/system/etc/permissions/

adb shell mkdir $BASE_PATH/system/priv-app/gappstub
adb push androidauto/gappstub/gappsstub.apk $BASE_PATH/system/priv-app/gappstub/

adb shell mkdir $BASE_PATH/system/priv-app/speechservicestub
adb push androidauto/speechservicestub/speech-services-stub.apk $BASE_PATH/system/priv-app/speechservicestub/


# Install backup script might brick device
adb push files/51-aurora_playstore_aa.sh $BASE_PATH/system/addon.d/

echo "Installation finished"

if [ $TARGET -eq 1 ]; then
  read -p "To not reboot the device press CRTL+c NOW"
  echo "Rebooting device"
  #Reboot device
  adb reboot
fi


