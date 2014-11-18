---
layout: steroids_build
header_title: Install a build onto your device
header_sub_title: Learn how to get your app from the Build Service on to your device.
section_id: build-settings
subsection_id: installing-onto-device
parent_id: steroids
---
<section class="docs-section" id="installing-onto-device">

# Installing onto device

In order to test a custom build you've downloaded from the [Build Service](https://cloud.appgyver.com), you have to install it onto your device.

## Android

[adb](http://developer.android.com/tools/help/adb.html) (Android Debug Bridge) allows you to install Android apps (APKs) on Android devices from the command line.
adb comes with [Android Development Tools](http://developer.android.com/tools/help/adt.html). In order to use adb with a device connected over USB, you need to enable USB debugging on device. For installation instructions and enabling USB debugging, see the [Console output with Android Developer Tools guide][adb-console-output].

Before issuing the adb install command, it is helpful to know what devices are connected. Connect your device to your computer with a wire. Then, you can generate a list of attached devices by running `adb devices` in Terminal. In order install your app on the device, run:

    $ adb install <path_to_apk>

With the `install` command, you need to specify the path to the .apk file that you want to install.

## iOS

An iOS iOS lets you install Scanner and Ad Hoc builds only on pre-approved devices as listed in the provisioning profile of app. App Store builds can only be installed via App Store, so you cannot run or debug them on your device before App Store submission. There are several ways to install iOS apps (IPAs) on iOS devices. Two of them is introduced below.

### Xcode

Open Xcode and connect your device to your computer with a wire. Open Xcode's Organizer by selecting *Window* from the top menu. Then, select *Devices*. You should see your device listed on the Side Bar. Select the device. If you don't see your device, make sure there is no permission prompt displayed in the device (accept it if there is) and disconnect and reconnect the device.

<img src="https://appgyver-academy-assets.s3.amazonaws.com/images/install_app/install_with_xcode.png" width="100%">

Then, just drag and drop your IPA from Finder into the *Installed Apps* box.

### iTunes

Open iTunes and select the device icon from top bar. From the *Side Bar*, select *Apps*. Then, drag and drop your IPA from Finder to *Apps*. Select your device under *DEVICES* After the app appears in the list of apps, click *install* for your application and sync.
</section>

[adb-console-output]: /steroids/cli/debugging/debugging-on-android/