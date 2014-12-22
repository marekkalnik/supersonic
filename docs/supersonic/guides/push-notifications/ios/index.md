---
layout: guides_push_notifications
header_sub_title: APIs having to do with the properties and hardware of your mobile device.
parent_id: supersonic
section_id: ios
---

<section class="docs-section" id="ios-overview">
# Push Notifications on iOS

Push Notifications can be tested using the AppGyver Scanner installed from App Store. This
will use AppGyver's certficates and App Store scanner cannot be inspected using
Safari Debugger. Hence, we recommend that you build your own custom scanner
when you are actually going to integrate push notifications to your application.

This guide will teach you to create the required certificates for the
Apple Push Notification Service (APNS). You will then use these certificates to
build an AppGyver Scanner. This is similar to the step which is required when
creating the publishable App Store build of your application.

</section>

# What is needed

As a first step, you will need to enroll to the Apple iOS Developer program.
You will need to have access to the iOS Developer Center at [developer.apple.com](developer.apple.com).



## Certificates and a Provisioning Profile

There are two different certificates involved:
  * iOS developer certificate which is used to sign your iOS application.
  * Push Notification certificate which is used by your Push Notification backend.

Certificate used for Push Notifications on the server side must match your
certificate that you have built your application with.

You must be very careful to use development Apple assets for debug Scanner/Adhoc
builds and distribution Apple assets for the App Store build (and non-debuggable Scanner/AdHoc build).
In other words, do *not* create a debug build in the AppGyver Build Service
using use a distribution certificate or distribution provisioning
profile.


## Push Notification Backend
For the push notification backend you can setup a simple sender using
[Pushmeup](https://github.com/NicosKaralis/pushmeup). Follow the instructions
in it's README.

If you are not comfortable setting
your own service for testing, you can also use a third-party provider such as
  * [Amazon Simple Notification Service](https://aws.amazon.com/sns/)
  * [Pushwoosh](https://www.pushwoosh.com/)
  * [Openpush](http://openpush.im/)
  * [Urban Airship](http://urbanairship.com/products/mobile-app-engagement)



# Configuring your iOS client build

## Creating the Developer Certificate (for iOS app)

(Tähän paste docissta kohdat 7- eteenpäin)

# Configuring your backend

## Creating the Push Notification Certificate

(Tähän paste google docsista kohdat 1-6)
