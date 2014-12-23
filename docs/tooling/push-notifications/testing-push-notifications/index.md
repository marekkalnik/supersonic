---
layout: steroids_push_notifications
header_sub_title: Testing Push Notifications
parent_id: tooling
section_id: testing-push-notifications
---

# Testing Push Notifications

This guide will cover the steps to testing push notifications by sending a notification directly from your computer to your device and receiving it through Supersonic.


## What is needed

For receiving Push Notifications on your device you will need to have successfully built a Scanner client with the Push Notification plugin enabled. See the guides for doing this on [iOS][ios-setup] and [Android][android-setup].

We will be using a Ruby gem to send push notifications, so you will also need to [have Ruby gems installed](https://rubygems.org/pages/download).

We be using Supersonic's Javascript API to handle notifications, so we'll assume you have an existing Supersonic application set up.

[ios-setup]: /supersonic/guides/tooling/push-notifications/ios
[android-setup]: /supersonic/guides/tooling/push-notifications/android


## Preparing to send notifications

You can find an example script on sending push notifications from your computer at the [PushNotification plugin repository][examples]. Either clone the repository or copy the examples locally.

[examples]: https://github.com/AppGyver/PushNotifications/tree/master/Example/server

There are separate scripts for APNS (iOS) and GCM (Android), and these will require separate setup steps.

To run either of the scripts, you will need to have the `pushmeup` Ruby gem. To install via gems, run:

    $ sudo gem install pushmeup

You should now be able to execute the scripts, eg like this assuming you've chosen to clone the repository:

    $ ruby Example/server/pushGCM.rb

However, the scripts will fail to authenticate if you do so. You will need to set up authentication for your push notification server and acquire a device registration ID.

### Authenticating (iOS)

When you created a push notification certificate for your Scanner client, you will have gotten an `aps_development.p12` file. Convert this file to a `ck.pem` file using the Keychain Access manager.

There is a line in the `pushAPNS.rb` file that describes the location of your `ck.pem` file. Change it to match where you saved the file.

    APNS.pem  = '</path/to/my/certificate/ck.pem>'

The certificate is also accompanied by a password. Change the following line to match the password you generated your certificate file with.

    APNS.pass = '<myCertificatePassword>'

### Authenticating (Android)

When configuring your Scanner client you will have created a Google API project. Ensure that you have the project ID at hand - you'll need it in a later step - and obtain an [application API key](http://developer.android.com/google/gcm/gs.html).

There is a line in the `pushGCM.rb` file that defines an application API key. Change it to match yours.

    APPLICATION_API_KEY = "API_KEY_GOES_HERE"


## Preparing to receive push notifications

Sending notifications to your device will require a device registration identifier, which can be acquired only from your device through a successful registration to push notification services.

### Registering (iOS)

In your Supersonic app, run:

    supersonic.device.push.register()

### Registering (Android)

In this step you will need the Google project ID for your application.

In your Supersonic app, run:

    supersonic.device.push.register {
        senderID: YOUR_PROJECT_ID
    }

### Extracting the device registration ID

After a successful registration, you will be able to see the device registration ID in the Steroids Connect logs.

### Connecting the server to the client

Both `pushAPNS.rb` and `pushGCM.rb` contain a line that configures the target device to send the push notification to. Copy the device registration ID you just extracted and place it in the appropriate file (`pushAPNS.rb` for an iOS device and `pushGCM.rb` for an Android device).

    DEVICE_REGISTRATION_ID = "REGISTRATION_ID_GOES_HERE"

Now, running the appropriate script should send a push notification to your device. Next we'll observe the arriving notification through Javascript.


## Observing push notifications in a Supersonic application

Using Supersonic you can access a stream of values representing incoming push notifications. They come in two kinds: `foregroundNotifications`, which are received while the application is open, and `backgroundNotifications` which are received if the application is running but not on the screen.

As an example, to alert the contents of a notification when one arrives while the application is open, you can run

    supersonic.device.push.foregroundNotifications().onValue (notification) ->
        supersonic.ui.dialog.alert(notification.message || notification.alert)

Remember to register before trying this! Also note that the payloads for a notification are different on iOS and Android; most importantly the notification content will be in `alert` on iOS and `message` on Android.

See the [API documentation][api] on `supersonic.device.push` for more details.

[api]: /supersonic/api-reference/stable/supersonic/device/push/
