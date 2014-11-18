---
layout: steroids_build
header_title: Build Settings for Android
header_sub_title: Configure the Build Settings for your Android app.
section_id: build-settings
subsection_id: build-settings-for-android
parent_id: steroids
---
<section class="docs-section" id="build-settings-for-android">
#Build settings for Android

### Related Guides
* [Android build types][android-build-types]
* [Configuring custom plugins for your app][custom-plugin-config]

The AppGyver Build Service lets you create an APK package of your application that you can distribute either ad hoc or submit to Google Play.

All Android application builds need to be signed with a suitable private key, stored in a `.keystore` file. You can use the same private key for multiple apps. When you upload an app to Google Play, all future updates to that app require your private key.

**If you lose the `.keystore` file bound to your app on Google Play, there's no way to update your app anymore, so keep it safe!**

## Generating a .keystore file

The `keytool` command comes bundled with the [Android SDK][android-sdk] and [Xcode][xcode] Command Line Tools – install either one, if you haven't already.

Next up, you need to obtain a suitable private key. The Android develeper portal article on signing your application has a section on [obtaining a suitable private key][android-dev-cert] that has more robust information, but basically, you need to run the following command in a Terminal window:

```
$ keytool -genkey -v -keystore my-app-name.keystore -alias my_keystore_alias
-keyalg RSA -keysize 2048 -validity 10000
```

This will start generating a RSA-encrypted, 2048 bit keypair with a validity of 10,000 days.

1. You will be first prompted for a password. Enter something you'll remember, alphanumerics only. **Note that special characters (e.g. other than letters and numbers) cause the `.keystore` file to be invalid.**
2. You'll then be prompted for a bunch of personal information, like your first and last name and your organization. You can leave all these empty.
3. Finally, you're asked for a password for your keystore alias. You can just press enter to use the same password as for the keystore itself.

As a result, you get a `my-app-name.keystore` file, which you'll be uploading momentarily to the AppGyver Build Service.

It's a good pattern to use a unique `.keystore` file for every app you have, although nothing stops you from using the same file for multiple apps. Remember, if you lose the `.keystore` file, you can't update the associated apps on Google Play anymore.

## Using the AppGyver Build Service

Now that you have the `.keystore` file, we can build your APK.

First, you need to create a cloud-deployed build of your app. You can do this with `$ steroids deploy` in your project folder. See the [cloud deployment guide][cloud-deploy] for more information.

After you have deployed your app to the cloud, you need to set up a bunch of options so that we can build your app properly. Go to [cloud.appgyver.com][appgyver-cloud], click on your app and then on the Configure Build Settings button.

Let's go through what you need to do in each section.

### Keystore

* Upload your Android `.keystore` file, the one you just generated.
* Enter your keystore password.
* Enter your keystore alias.
* Enter your keystore alias password.

### Google Play Build and Ad Hoc Build

Note that Android doesn't distinguish between Google Play and Ad Hoc builds. The different build types are so that you can easily have two versions of your app installed on the same device, with different names and package identifiers.

For example, if you have published your app to Google Play or some other app store, you might want to keep a separate development version on the side via Ad Hoc Build, so you don't have to overwrite your latest stable store release.

For both Google Play and Ad Hoc Build, you need to enter:

* Display Name for your app. This name will be shown under your app's icon on the device. Around 20 characters is a good length.
* Package Identifier for your app. This must be a reverse-domain, Java-language-style package name, e.g. `com.phoenixfoundation.macgyverapp` (or `com.phoneixfoundation.macgyvertest` for an Ad Hoc build). You can use letters, numbers and underscores, but individual package name parts must start with letters. Don't use the `com.example` namespace when publishing your app. The package name has to have at least two parts, i.e. just `myappname` won't work but `com.myappname` will.
* Version Code. This is an internal version number, set as an integer, e.g. "100". Each successive version of your app must have a higher Version Code.
* Version Number. The version number shown to users, e.g. "1.0".

### Scanner build

The Scanner Build is a special build of your application intended for development with the Steroids CLI. It allows you to create a Scanner app that includes the custom plugins defined in the plugins field. As such, a Scanner Build doesn't show your actual application, but rather lets you scan a QR code to connect to a computer running the Steroids server.

### Plugins

See the [custom plugins config guide][custom-plugin-config] for more information on using custom plugins with your app.

### Shared Settings

Set the [Android orientation mode][android-dev-orientation] to one of the available options.

### Requested permissions

The usage permissions that your app will request from the user when it is installed. Disabling these can affect the functionality of Cordova API namespaces (e.g. disabling Camera will disable Cordova's `navigator.camera`).

### Custom URL schemes

The `Custom Protocols` field lets you enter custom URL schemes for your app; see the [custom URL scheme guide][custom-url-scheme-guide] for more information!

### Icons

Different density icons for your app. Android apps should have icons with transparent backgrounds.

### <a name="Splashscreens"></a> Splashscreens

Different density splashscreens for your app. They should optimally be 9-Patch PNG images, which is an Android-specific image format that allows defined sections of the image to be stretched without distorting the whole image. Please see [Android's API docs on 9-Patch PNG's][android-dev-ninepatch] for more information about the format.

If the app uses regular PNG splashscreens, the different sizes must be the explicit pixel sizes defined for each format. With 9-Patch format the image can be smaller than the defined maximum.

The different maximum sizes for the splashscreens are as follows:

- xlarge (xhdpi): 640x960 pixels
- large (hdpi): 480x800 pixels
- medium (mdpi): 320x480 pixels

#### 9-Patch Splashscreens

You can use [Draw 9-Patch application](http://developer.android.com/tools/help/draw9patch.html) which comes with your Android SDK to create the 9-Patch PNG files.

For reference, see the AppGyver 9-patch splashscreen used as default in all Steroids Android projects below. You can download the splashscreen by clicking it and open it in Draw 9-Patch to see how it works.

<a href="https://cloud.appgyver.com/assets/application_defaults/android_xhdpi_splashscreen.9.png" target="_blank"><img src="https://cloud.appgyver.com/assets/application_defaults/android_xhdpi_splashscreen.9.png" style="width: 100%;" border="0"/></a>

In a nutshell:

- 1px wide black markers define areas for both content area and stretchable area.
- Markers on TOP and LEFT are stretch markers: this area will grow according to the screen size.
- Markers on RIGHT and BOTTOM define the content (fill) area which will not be stretched.
- Guides must be solid black (#000000). Even a slight difference in color (#000001) or alpha will cause it to fail and stretch normally.
- Remaining area of the one-pixel outline must be completely transparent.

For a visual explanation of the markers, see the image below (click to open image in its full size):

<a href="https://appgyver-academy-file-attachments.s3.amazonaws.com/file_attachments/images/000/000/912/original/9patch-stretch.jpg?1414570490" target="_blank"><img src="https://appgyver-academy-file-attachments.s3.amazonaws.com/file_attachments/images/000/000/912/original/9patch-stretch.jpg?1414570490" style="width: 100%;" border="0"/></a>

Please see these following third party guides for a more thorough explanation:

- [StackOverFlow: 9-Patch Drawable Dimensions](http://stackoverflow.com/questions/14972657/9-patch-drawable-dimensions-android-how-do-different-densities-handle-the-non-s/14982540#14982540)
- [StackOverFlow: 9-Patch splashscreen image sizes to fit all devices](http://stackoverflow.com/questions/10574363/android-splash-screen-image-sizes-to-fit-all-devices/15744389#15744389)

## Building your APK

After you're done, click Update Settings. Then, you can use the Build an Ad Hoc build and Build for Google Play buttons on the Build for Distribution tab to request a new build of your app.

Building the app takes a few moments, after which you'll get an e-mail with a link to the downloadable APK. You can also see your build history and download earlier builds by clicking on the Show Build History button.

[android-build-types]: /steroids/build-service/build-settings/android-build-types
[android-dev-cert]: http://developer.android.com/tools/publishing/app-signing.html#cert
[android-dev-ninepatch]: http://developer.android.com/guide/topics/graphics/2d-graphics.html#nine-patch
[android-dev-orientation]: http://developer.android.com/reference/android/R.attr.html#screenOrientation
[android-sdk]: http://developer.android.com/sdk/index.html
[appgyver-cloud]: http://cloud.appgyver.com
[cloud-deploy]: /steroids/build-service/build-settings/deploying-to-cloud
[custom-plugin-config]: /steroids/build-service/plugins/configuring-custom-plugins
[custom-url-scheme-guide]: /supersonic/guides/navigation/navigating-between-apps/communicating-with-external-apps
[xcode]: https://developer.apple.com/xcode/
</section>