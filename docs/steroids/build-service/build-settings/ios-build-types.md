---
layout: steroids_build
header_title: Build types for iOS
header_sub_title: Learn about the different iOS build types available to you.
section_id: build-settings
subsection_id: ios-build-types
parent_id: steroids
---
<section class="docs-section" id="build-types-for-ios">

# Build types for iOS

There are several different build types to choose from in the [AppGyver Cloud Service](https://cloud.appgyver.com/applications/). Below is a quick rundown of their general differences.

## Adhoc build

An adhoc build is a standalone version of your cloud deployed project, which can be installed on your device and behaves essentially like any App Store app would. However, it can only be installed on pre-approved devices as listed in the provisioning profile that was uploaded as part of the [build settings][build-settings].

#### Debug adhoc

The debug adhoc is the same as a regular adhoc, except it enables monitoring the the app through Safari Web Inspector, allowing you to debug your app on a physical device. Note that adhoc and debug adhoc require different certificates in the build service, see the [debug build guide][debug-build] for more info.

## Scanner build

A Scanner build is just a Scanner that uses any custom plugins you have defined in your build settings. Even though it is built from the cloud deploy of a specific Steroids project, it is not tied to that particular project or deploy, but can (and should) be used to demo Steroids projects via a scanned qr code, just like the official AppGyver Scanner.

#### Debug Scanner

Much like the debug adhoc, the debug Scanner has the added functionality of allowing you to debug your app with Safari Web Inspector. Once again you have to provide a different certificate than for the regular Scanner build, see the [debug build guide][debug-build].

## App Store build

The App Store build packages your app to be ready for App Store submission. This build type can not be run or debugged before submission.
</section>

[build-settings]: /build-service/build-settings/build-settings-for-ios/
[debug-build]: /steroids/build-service/build-settings/building-a-debug-build/