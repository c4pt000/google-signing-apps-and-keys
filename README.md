```
java -jar bundletool-all-1.17.0.jar build-apks --bundle=Bit__arm64-v8a-release.aab --output=testing-my_app.apks --mode=universal 
unzip -p testing-my_app.apks universal.apk > universal-testing.apk
test universal-testing.apk as debug-signed works
```

https://developer.android.com/build/building-cmdline#build_bundle

# google-signing-apps-and-keys

# step 1 new application signing
![s1](https://github.com/c4pt000/google-signing-apps-and-keys/releases/download/png/signing-1.png)


![s1](https://github.com/c4pt000/google-signing-apps-and-keys/blob/main/signing-2.png)

# changing key request first time

```
Suggest using “randomstring”

yum install curl -y
or
apt-get update && apt install curl -y

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

source ~/.bashrcnvm install 21
nvm use 21
npm -g install randomstring
yum install java-17-openjdk-headless java-17-openjdk java-17-openjdk-devel

randomstring > google-key.txt

cp -rf ~/Downloads/pepk.jar
cp -rf ~/Downloads/encryption_public_key.pem

this string should be saved its your random password for the signing key
and my-release-key.jks should be kept safe

cat google-key.txt

keytool -genkey -v -keystore my-release-key.jks -alias alias_name -keyalg RSA -keysize 2048 -validity
10000

java -jar pepk.jar --keystore=my-release-key.jks --alias=alias_name --output=output.zip --include-cert
--rsa-aes-encryption --encryption-key-path=encryption_public_key.pem

output.zip will be created here use this to upload to the request key update
```
# actually signing the app bundle
```
after ./gradlew assembleRelease to create the .apk
creating appBundle .aab usually has to take place manually with the project folder as

./gradlew bundleRelease

acutally signing the appbundle .aab (using the exact same key that matches from my-release-key.jks
google-key.txt)



                                                                            #ignore this previously not signed properly -> jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 -keystore my-release-key.jks APP_NAME__arm64-v8a-release.aab alias_name


jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 -keystore my-release-key.jks -signedjar YOUR_APP-_arm64-v8a-release.aab YOUR_UNSIGNED_AAB__arm64-v8a.aab alias_name


```

# if you lose the signing key completely.....


# if you acutally misplace the signing key completely (process takes 24-48 hours for google to approve the new upload key)

![s1](https://github.com/c4pt000/google-signing-apps-and-keys/releases/download/png/first-if-lose-1.png)

![s1](https://github.com/c4pt000/google-signing-apps-and-keys/releases/download/png/if-lose-key-2.png)



# this isnt usually necessary for a brand new app to be signed its only if a signing key is lost or misplaced to sign an application previously......
# then repeat step 1 for signing new app with a key

* my own prefernce is to use the exact same java-keystore as my-release-key.jks for the upload-keystore.jks also
```

randomstring > google-key.txt

this string should be saved its your random password for the signing key
and my-release-key.jks should be kept safe

cat google-key.txt

keytool -genkey -v -keystore my-release-key.jks -alias alias_name -keyalg RSA -keysize 2048 -validity 10000

same exact key from google-key.txt

keytool -export -rfc -keystore my-release-key.jks -alias alias_name -file upload_certificate.pem
```

# cordova as an html/js app builder

```
see also cordova for actually building html/js applications completely

npm -g install cordova serve
cordova create myappname org.apache.cordova.myappname myappname
cd myappname

"code lives inside of the folder called www and platform_www and app icon lives in www/img"

cordova platform add android
cordova platform add ios

cordova build android --release -- --packageType=bundle
```

# testing an AAB to APK to test the AAB
```
#testing aab
wget https://github.com/c4pt000/google-signing-apps-and-keys/releases/download/png/777.aab.tar
tar -xvf 777.aab.tar

#install bundletool

wget https://github.com/google/bundletool/releases/download/1.17.0/bundletool-all-1.17.0.jar
cp -rf bundletool-all-1.17.0.jar /usr/bin/bundletool.jar
alias bundletool="java -jar /usr/bin/bundletool.jar"

bundletool build-apks --bundle=777.aab --output=myapp.apks --mode=universal
unzip myapp.apks -d apks


#same key used to create my-release-key.jks here from above or a new key
keytool -genkey -v -keystore my-release-key.jks -alias alias_name -keyalg RSA -keysize 2048 -validity 10000

#your current installed build-tools directory from /opt/Android/Sdk or otherwise
~/opt/Android/Sdk/build-tools/34.0.0-version-here-of-buildtools/apksigner sign --ks my-release-key.jks --out testing-universal.apk apks/universal.apk
```



