# Android AuroraServices, Phonesky and AndroidAuto installation helper for microg
Installation helper for auroraservices, phonesky (play store with iap) and android auto on microg (tested on los4microg 19).
Credits go out to Nanolx, AuroraOSS, JQuilty, the microg team, the lineageos team, all the guys talking in https://github.com/microg/GmsCore/issues/897#issuecomment-1159444100 and everyone i forgot to mention.

## About this script
This script will help installing the files to the system partition via adb. 
The files can either be installed from the running android system or from the lineageos recovery.
If you want to install the files via the live android system make sure root access for the shell is enabled in the developer options.
If you want to install the files via the lineageos recovery enable adb and mount system in the recovery settings.

Parts that should not be installed have to be commented out in the script.
Fakestore (preinstalled by microg) will be remvoed during phonesky installation.

## Download Files
### Phonesky
Get a phonesky apk e.g. https://nanolx.org/fdroid/repo/Phonesky_132.apk and copy the to the phonesky subdir, rename it to "Phonesky.apk".

### AuroraServices
Get the latest AuroraServices ota zip from https://gitlab.com/AuroraOSS/AuroraServices (e.g. AuroraServices-v1.1.1-ota.zip) and extract its content to the auroraservices subdir.

### Android Auto
Get the latest android auto stub files from https://github.com/JQuilty/android-auto-stub and place the files in the androidauto subdirectory.

## Example of file structure
Your directory should now look like this:

```
/phonesky/Phonesky.apk
/auroraservices/AuroraServices.apk
/auroraservices/com.aurora.services.xml
/androidauto/speechservicestub/speech-services-stub.apk
/androidauto/gappstub/gappsstub.apk
/androidauto/AndroidAuto/AndroidAutoStubPrebuilt.apk
/files/privapp-permissions-com.google.android.projection.gearhead.xml
/files/permissions-com.android.vending.xml
/files/51-aurora_playstore_aa.sh
/install_aurora_phonesky_aa.sh
```

## Run the script
When running the script (install_aurora_phonesky_aa.sh) you'll be asked if you want to install the files via the running android live system or the lineageos recovery (TWRP might work too, there be dragons!).

## Install microg updates
The backup script is NOT FUNCTIONAL!
When you install a microg update you will need a computer to rerun this script or else your phone will not boot anymore (boot loop).
I have no idea why this is not working yet maybe someone does want to help out here.
Maybe this is due to the update is reinstalling the Fakestore and then the two packages are in conflict.

## After installation
After the files are copied and the system is booted you can install Android Auto, the GoogleApps and the voice search from the playstore.
Maybe the files can also be installed via the Aurora Store app, this is not tested.

## Info about Android Auto
I do not have an app icon after installing Android auto, i can only access ts settings when searching for "Auto" in the device settings.
This is the "new" Android Auto behaviour so do not freak out when you can not find an app icon. YMMV.

The gapps and speech services do not have to be installed as stubs and can be  installed directly from playstore but I had "Application has stopped working" messages from time to time which are gone after installing the stubs.

