---
layout: docs_first_mile
title: Supersonic Documentation
header_title: Distributing Supersonic apps
header_sub_title: Learn how to build and distribute your apps.
section_id: fourth-mile
subsections:
  - name: Overview
  - name: Deploying to cloud
  - name: Sharing your progress
  - name: Configuring a build
  - name: Installing onto device
  - name: Publishing to app stores
---

<section class="docs-section" id="overview">
## Overview

In this section you will learn:

- How to deploy your app to the AppGyver cloud and share it with friends or co-workers
- How to configure and request a build from the AppGyver Build Service
- How to publish your finished app

Note that building and releasing an app is an inevitably time-consuming process, so completing this mile might take a while, but the skills learned are going to be very useful to you sooner or later.
</section>

<section class="docs-section" id="deploying-to-cloud">
##Deploying to cloud
To deploy your app to the AppGyver Cloud the easiest way to do so is to use the Steroids Connect screen. Open the Connect screen (if you've closed it, run `qr` in the Steroids Development Server console to open it again), and head to the Cloud settings tab.

Ensure you're connected to the Internet and click on "Deploy to cloud". This will cause Steroids CLI to deploy your app to the cloud. Wait for it to finish, after which the screen will update to show the app id of the deployed build and a link to the Cloud Share page, from where you can share your app with others.

<img src="http://appgyver-academy-assets.s3.amazonaws.com/images/connect/Steroids_connect_predeploy.png" alt="Steroids connect screen">
</section>

<section class="docs-section" id="sharing-your-progress">
## Sharing your progress
To share your app with others, you need a Cloud QR code. It is generated when you deploy your app to the AppGyver Cloud. To access it, open the "Open cloud share page" link in the Steroids Connect screen.

<img src="http://appgyver-academy-assets.s3.amazonaws.com/images/connect/Steroids_connect_post_deploy.png" alt="Steroids connect screen">

You can then share your app with others by copy-pasting the link to that share page. Others can then use their AppGyver Scanners or the Simulator embedded into the page to preview your app.
</section>

<section class="docs-section" id="configuring-a-build">
## Configuring a build

There are essentially three situations when you need to request a build from the AppGyver build Service:

1. You want to demo your app in a standalone build
2. You need to use a custom PhoneGap plugin in your app (see the [Extending with plugins][plugins-guide] for instructions on plugin usage)
3. You are ready to release your app.

So the general development workflow is based heavily around using Scanners and the QR code, but some special cases and the final release process require a separate build. The build setup process differs somewhat depending on which platform you are using, follow the links below to see how to set up builds for Android and iOS platforms.

- [Build settings for Android][android-build-guide]
- [Build settings for iOS][ios-build-guide]

</section>
<section class="docs-section" id="installing-onto-device">
## Installing onto device

For full instructions on installing your app onto a device, see [the guide][install-guide].
</section>
<section class="docs-section" id="publishing-to-app-stores">
## Publishing to app stores

Publishing to app stores requires that you build an app store version of your app and go through the required setup in the respective store pages.

For Android:

1. Build a Google Play build from the [Build Service][build-service]. The resulting `.apk` will be the app you publish to the Play Store.
2. Go through the [Google launch checklist](http://developer.android.com/distribute/tools/launch-checklist.html) and upload your app to the store.

For iOS:

1. Build a Distribution -> App Store build of your app. Unlike other build types, you will receive a `.zip` file as the result of your build. You need to use the entire `.zip` when uploading to the App Store, and you cannot test the App Store build beforehand.
2. Go through the [Apple submission guide](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/SubmittingYourApp/SubmittingYourApp.html#//apple_ref/doc/uid/TP40012582-CH9-SW1)

</section>

[android-build-guide]: /steroids/build-service/build-settings/build-settings-for-android/
[install-guide]: /steroids/build-service/build-settings/installing-onto-device/
[ios-build-guide]: /steroids/build-service/build-settings/build-settings-for-ios/
[plugins-guide]: /steroids/build-service/plugins/configuring-custom-plugins/