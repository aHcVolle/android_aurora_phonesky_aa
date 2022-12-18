#!/sbin/sh
#
# ADDOND_VERSION=3
#
# /system/addon.d/30-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/AuroraServices.apk
etc/permissions/com.aurora.services.xml
priv-app/Phonesky/Phonesky.apk
etc/permissions/permissions-com.android.vending.xml
priv-app/AndroidAuto/AndroidAutoStubPrebuilt.apk
etc/permissions/privapp-permissions-com.google.android.projection.gearhead.xml
priv-app/gappstub/gappsstub.apk
priv-app/speechservicestub/speech-services-stub.apk
addon.d/51-aurora_playstore_aa.sh
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    for i in $(list_files); do
      f=$(get_output_path "$S/$i")
      chown root:root $f
      chmod 644 $f
      chmod 755 $(dirname $f)
    done
    rm -rf system/priv-app/FakeStore
    rm -rf priv-app/FakeStore
  ;;
esac
