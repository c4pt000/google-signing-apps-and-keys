# google-signing-apps-and-keys


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

jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 -keystore my-release-key.jks
APP_NAME__arm64-v8a-release.aab alias_name
```

# if you acutally misplace the signing key completely

![s1](https://github.com/c4pt000/google-signing-apps-and-keys/releases/download/png/first-if-lose-1.png)

![s1](https://github.com/c4pt000/google-signing-apps-and-keys/releases/download/png/if-lose-key-2.png)

generate a new my-release-key.jks file and export to the upload_Certificate.pem

 keytool -export -rfc -keystore my-release-key.jks -alias upload -file upload_certificate.pem


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

