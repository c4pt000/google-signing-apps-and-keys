#!/bin/bash
echo "requires around 20gb of free space"
sleep 2s
echo "******CAUTION*******"
echo "******CAUTION*******"
echo "******CAUTION*******"
echo "THIS SCRIPT WILL UPDATE GRUB2 bootloader automatically to enable iommu for KVM for hardware x86 functions of the android emulator crtl-C to cancel this script to review the script, script will pause for 10 seconds while you decide"
echo "******CAUTION*******"
echo "******CAUTION*******"
echo "******CAUTION*******"
sleep 10s

echo "where /root/Android/Sdk is the android-studio install dir"
sudo -i
cd /opt
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.1.1.12/android-studio-2024.1.1.12-linux.tar.gz
tar -xvf android-studio-2024.1.1.12-linux.tar.gz
sh android-studio/bin/studio.sh
#install cmdline-tools in studio

echo '
export ANDROID_SDK_HOME=/root/Android/Sdk
export PATH=$PATH:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/lib/snapd/snap/bin:/usr/bin/gradle-7.1/bin:/root/Android/Sdk/tools/bin:/root/Android/Sdk/tools:/root/Android/Sdk/platform-tools/:/root/Android/Sdk/build-tools/29.0.2/:/root/Android/Sdk/tools/bin/
' >> /root/.bashrc

source /root/.bashrc


alias avdmanager=/root/Android/Sdk/cmdline-tools/latest/bin/avdmanager 
alias sdkmanager='/root/Android/Sdk/cmdline-tools/latest/bin/sdkmanager  --sdk_root=/root/Android/Sdk'


sdkmanager --install "platforms;android-34"
sdkmanager --install "build-tools;34.0.0"
sdkmanager --install "system-images;android-34;google_apis_playstore;x86_64"
echo "no" | avdmanager --verbose create avd --force --name Nexus --package "system-images;android-34;google_apis_playstore;x86_64"


echo '
#!/bin/bash
QTWEBENGINE_DISABLE_SANDBOX=1 /root/Android/Sdk/emulator/emulator @Nexus -no-boot-anim -netdelay none -no-snapshot -wipe-data -skin 800x1440 & 
' > /usr/bin/EMULATOR
chmod +x /usr/bin/EMULATOR




echo "it is mandatory to reboot now"
echo "if kvm is loaded run the EMULATOR script"
echo "on reboot"
echo "lsmod | grep kvm"
echo "/usr/bin/EMULATOR should spawn a Nexus style android emulator run adb install apkfilename.apk or "adb shell" then "logcat" to inspect running emulator, apk"
https://play.google.com/store/apps/details?id=org.electrum.bit
https://play.google.com/apps/internaltest/4701642141669384422
