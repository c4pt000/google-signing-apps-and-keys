wget https://github.com/c4pt000/google-signing-apps-and-keys/releases/download/png/777.aab.tar
tar -xvf 777.aab.tar

#install bundletool

wget https://github.com/google/bundletool/releases/download/1.17.0/bundletool-all-1.17.0.jar
#cp -rf bundletool-all-1.17.0.jar /usr/bin/bundletool.jar
#alias bundletool="java -jar /usr/bin/bundletool.jar"

sleep 5s
java -jar bundletool-all-1.17.0.jar build-apks --bundle=777.aab --output=myapp.apks --mode=universal
unzip myapp.apks -d apks


#same key used to create my-release-key.jks here from above or a new key
keytool -genkey -v -keystore my-release-key.jks -alias alias_name -keyalg RSA -keysize 2048 -validity 10000

#your current installed build-tools directory from /opt/Android/Sdk or otherwise
/home/c4pt/Android/Sdk/build-tools/34.0.0/apksigner sign --ks my-release-key.jks --out testing-universal.apk apks/universal.apk


echo "install testing-universal.apk to phone to test bundle aab as an APK working"
