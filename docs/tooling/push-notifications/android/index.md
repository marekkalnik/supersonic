---
layout: steroids_push_notifications
title: Supersonic Documentation
header_sub_title: Push Notifications on Android
parent_id: tooling
section_id: android
---
<section class="docs-section" id="overview">

# Push Notifications on Android

This guide will teach you how to use the Google Cloud Messaging (GCM) service to send push notifications to your Android app. You will build a custom Scanner app with the push notification plugin enabled – on Android, nothing more is required.

</section>

<section class="docs-section" id="setting-up-gcm">
## Setting Up Google Cloud Messaging

To send push notifications, you need to set up Google Cloud Messaging (GCM). Google has excellent instructions for this, so simply follow the steps outlined in Google's [Getting Started guide](http://developer.android.com/google/gcm/gs.html).

After completing the steps, you will have:

* Your GCM Sender ID, which equals to your Google API project number, e.g. `670330094152`.
* A private GCM API key, e.g. `azAIByXpLR8p234mxRJDQdG9dVd_JyUypsGfsEs`.

Note that during Step 4 of the "Obtaining an API key", you can just leave the IP addresses field empty.
</section>

<section class="docs-section" id="build-service-configuration">
## Configuring your app in the AppGyver Build Service
On Android, you can simply follow the [Build Service guides](/tooling/build-service/) to create a Scanner build. The only thing you need to do is check the Push Notifications checkbox. This will automatically include [AppGyver's PushNotification plugin](https://github.com/AppGyver/PushNotifications) in your build.

After you have successfully requested a build, head on over to the [Testing Push Notifications](/tooling/push-notifications/testing-push-notifications/) guide for the next steps.
</section>
