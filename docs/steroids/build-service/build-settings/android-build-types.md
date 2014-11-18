---
layout: steroids_build
header_title: Build types for Android
header_sub_title: Learn about the different Android build types available to you.
section_id: build-settings
subsection_id: android-build-types
parent_id: steroids
---
<section class="docs-section" id="build-types-for-android">

# Build types for Android

## Related guides

- [Android Build Configuration][android-build-config]

There are several different build types to choose from in the [AppGyver Cloud Service](https://cloud.appgyver.com/applications/). Below is a quick rundown of their general differences.

## Scanner build

A Scanner build is just a Scanner that uses any custom plugins you have defined in your build settings. Even though it is built from the cloud deploy of a specific Steroids project, it is not tied to that particular project or deploy, but can (and should) be used to demo Steroids projects via a scanned qr code, just like the official AppGyver Scanner.

## Standalone builds: Ad Hoc and Google Play

Ad Hoc and Google Play builds are standalone versions of your cloud deployed project, which can be installed on your device. Please note that Android doesn't distinguish between Google Play and Ad Hoc builds. The different build types are so that you can easily have two versions of your app installed on the same device, with different names and package identifiers.

For example, if you have published your app to Google Play or some other app store, you might want to keep a separate development version on the side via Ad Hoc build, so you don't have to overwrite your latest stable store release.

## Crosswalk builds

All the Android build types described above are also available as Crosswalk builds. The Crosswalk builds use [Crosswalk](https://crosswalk-project.org/) for your app's WebView in place of the regular Android Webview. For further information:

* [check out the blog: Chromium Crosswalk: A huge boost to hybrid-apps on Android](http://blog.appgyver.com/heartbeat/steroids/android-chromium/)
</section>

[android-build-config]: steroids/build-service/build-settings/build-settings-for-android
