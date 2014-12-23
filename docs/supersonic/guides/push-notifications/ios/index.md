---
layout: guides_push_notifications
header_sub_title: Push Notifications on iOS
parent_id: supersonic
section_id: ios
---

<section class="docs-section" id="overview">
# Push Notifications on iOS

Push Notifications are messages sent via a backend server to an user's phone. If they have enabled push notifications for the app in question, they will receive a notification even if the app is closed.

This guide will teach you to create the required certificates for the Apple Push Notification Service (APNS). You will then use these certificates to build a custom AppGyver Scanner. This is similar to the steps you need to take when creating a stand-alone or publishable App Store build of your application.
</section>

<section class="docs-section" id="what-is-needed">
## What is needed

As a first step, you will need to be enrolled to the Apple iOS Developer program. You will need to have access to the iOS Developer Center at [developer.apple.com](developer.apple.com).

You should also have deployed your application to the Build Service via `steroids deploy` Don't worry if your code is not final yet. We will be first building a custom Scanner app that will allow you to test push notifications while making changes to your project.

### Certificates and a Provisioning Profile

To ensure that only you can send push notifications to your app, Apple requires some setup to be done before you build your app. This involves creating the correct certificates and provisioning profile, and uploading them to the AppGyver Build Service.

There are two different certificates involved:
  * iOS developer/distribution certificate which is used to sign your iOS application.
  * Push Notification certificate which is used by your Push Notification backend.

The certificate used for Push Notifications on the server side must match the certificate that you have built your application with.

You must be very careful to use development Apple assets for debug Scanner/Adhoc builds and distribution Apple assets for the App Store build (and non-debuggable Scanner/AdHoc build). In other words, do *not* create a debug build in the AppGyver Build Service using a distribution certificate or a distribution provisioning profile, as this will fail.

We will go through the process of setting up the certificates and a provisioning profile later in this guide.

### Push Notification Backend
For a simple test backend, please see the [Testing with the Pushmeup gem](TODO) guide.

If you are not comfortable setting up your own service for testing, you can also use a third-party provider such as

  * [Amazon Simple Notification Service](https://aws.amazon.com/sns/)
  * [Pushwoosh](https://www.pushwoosh.com/)
  * [Openpush](http://openpush.im/)

</section>

<section class="docs-section" id="configuring-your-ios-client-build"
## Configuring your iOS client build

To allow you to use the Safari Remote Web Inspector with your custom Scanner build, we will create a Debug Scanner. This requires you to use a **Developer Certificate** and a **Development Push Certificate**. You will also need to create a Provisioning Profile for your app. In the next sections, we will be creating the necessary files.
</section>

<section class="docs-section" id="ios-developer-certificate">
## Creating an iOS Developer Certificate

### Step 1: Create the Developer Certificate
1. Make sure you're logged in to the [Apple iOS Developer Center](https://developer.apple.com/devcenter/ios/index.action)
2. Open the [iOS Certificates (Development) list](https://developer.apple.com/account/ios/certificate/certificateList.action?type=development), under: Certificates, Identifiers & Profiles > Certificates > Development.
3. Click on the + button in the upper-right corner to open the new Development Certificate wizard.
4. Choose the iOS App Development option.
  <div class="row">
    <div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
      <img src="/img/tooling/push-notifications/ios-development-cert.png" style="width:100%">
    </div>
  </div>
5. Click Continue and follow the instructions given by the wizard to create a Certificate Signing Request. After completing the steps, you will have a CSR file. Store it so you can reuse it later on, when you will need to upload another CSR file.
6. Click Continue and upload the CSR file to Apple.
7. Click Download, which will download a `ios_development.cer` file.

### Step 2: Export the Development Certificate's private key
1. Double-click the `ios_development.cer` file downloaded in the previous step.
2. In the Add Certificates dialog that appears, select the **login** keychain and click Add.
<div class="row">
<div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
<img src="/img/tooling/push-notifications/ios-add-development-cert-to-keychain.png" style="width:100%">
</div>
</div>
3. You can now view the certificate and it's private key under the My Certificates category in Keychain Access.
*Note: the same information can also be viewed under the Keys category. Do not view/export it there, as this will cause errors!*
<div class="row">
<div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
<img src="/img/tooling/push-notifications/ios-keychain-access-development-cert.png" style="width:100%">
</div>
</div>
4. Right-click on your newly created Development Certificate and select Export.
5. You will be prompted to save the certificate in the `.p12` format. When asked for a password, write it down under your keyboard so you will remember it in a later step.
6. As a result, you will have a `.p12` file, e.g. `ios_development.p12`.
</section>

<section class="docs-section" id="provisioning-profile">
## Creating a provisioning profile
### Step 1: Create an App ID
1. Open the [iOS App IDs list](https://developer.apple.com/account/ios/identifiers/bundle/bundleList.action), under: Certificates, Identifiers & Profiles > Identifiers > App IDs.
2. Click on the + button in the upper-right corner to open the new App ID wizard.
<div class="row">
<div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
<img src="/img/tooling/push-notifications/ios-app-id.png" style="width:100%">
</div>
</div>
3. Choose **Explicit App ID** and enter an ID, e.g. `com.mycompany.push.debug.scanner`. (Wildcard App IDs will not work with push notifications.)
<div class="row">
<div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
<img src="/img/tooling/push-notifications/ios-app-services.png" style="width:100%">
</div>
</div>
4. Select the **Push Notifications** checkbox under App Services.
5. Click on **Continue** to see an overview, then click **Submit** to create the App ID.

### Step 2: Register your iOS Device
1. Connect your iOS device to your computer with a cable.
2. Get your device UDID.
    1. Open Xcode and select Window > Devices from the top menu.
    2. Click on your device and copy the Identifier string.
3. Open the [iOS Devices list](https://developer.apple.com/account/ios/device/deviceList.action), under: Certificates, Identifiers & Profiles > Devices > All
4. Click on the + button in the upper-right corner of your app to open the Add iOS Devices wizard.
<div class="row">
<div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
<img src="/img/tooling/push-notifications/ios-add-device.png" style="width:100%">
</div>
</div>
5. Click Continue and then Register to complete the process.

### Step 3: Create a Provisioning Profile
1. Open the [iOS Provisioning Profiles (Development) list](https://developer.apple.com/account/ios/profile/profileList.action?type=limited), under: Certificates, Identifiers & Profiles > Provisioning Profiles > Development


<section class="docs-section" id="push-notification-certificate">
## Creating a Push Notification Certificate

Next up, we need to create a Push Notification Certificate and export it. The steps required are very similar to the ones listed above, so please read the instructions carefully.

### Step 1: Create a development Push Notification Certificate
1. Open the [iOS Certificates (Development) list](https://developer.apple.com/account/ios/certificate/certificateList.action?type=development), under: Certificates, Identifiers & Profiles > Certificates > Development.
2. Click on the + button in the upper-right corner to open the new Development Certificate wizard.
3. Choose the Apple Push Notification service SSL (Sandbox) option.
    <div class="row">
      <div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
        <img src="/img/tooling/push-notifications/ios-push-cert.png" style="width:100%">
      </div>
    </div>
4. Click Continue.
5. Select the App ID that you created previously (e.g. `com.mycompany.push.debug.scanner`).
6. Click Continue and follow the instructions given by the wizard to create a Certificate Signing Request. After completing the steps, you will have a CSR file. Store it for later usage, you can use it again if you need to create new certificates later.
7. Click Continue and upload the CSR file to Apple.
8. After this, you will have a certificate whose Type is "APNs Development iOS" and whose Identifier ID will match the App ID you selected. Again, you must use a **Development** certificate with a **debug** build.
9. Click Download, which will download a `aps_development.cer` file.

### Step 2: Export the certificate's private key
1. Double-click the `aps_development.cer` file created in the previous step.
2. In the Add Certificates dialog that appears, select the **login** keychain and click Add.
    <div class="row">
      <div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
        <img src="/img/tooling/push-notifications/ios-add-push-cert-to-keychain.png" style="width:100%">
      </div>
    </div>
3. You can now view the certificate and it's private key under the My Certificates category in Keychain Access.
    *Note: the same information can also be viewed under the Keys category. Do not view/export it there, as this will cause errors!*
    <div class="row">
      <div class="col-sm-6 col-sm-6 col-md-9 col-lg-9 guide-image">
        <img src="/img/tooling/push-notifications/ios-keychain-access-push-cert.png" style="width:100%">
      </div>
    </div>
4. Right-click on your newly created Push Notification Certificate and select Export.
5. You will be prompted to save the certificate in the `.p12` format. When asked for a password, write it down under your keyboard so you will remember it in a later step.

### Step 3: Selecting a Push Notification provider

Finally, you need to use the exported certificate with a backend service that will actually send the push notifications. For simple local push notifications, please read the [Testing with the Pushmeup gem](TODO) guide.

There are also third-party push notification provider that provide their own guides for setup:

 * [Amazon Simple Notification Service](https://aws.amazon.com/sns/)
 * [Pushwoosh](https://www.pushwoosh.com/)
 * [Openpush](http://openpush.im/)

We do not give official support by AppGyver for any single provider, but since they all connect to the same Apple Push Notification Service, there's nothing blocking them from working, provided your app is set up correctly.

If you need to convert your certificate's `aps_development.p12` file to `aps_development.pem` format, you can do it with the command:

```
openssl pkcs12 -in aps_development.p12 -out aps_development.pem -nodes
```

##

Submit the same CSR file you created above.
Download the certificate (ios_development.cer) and double-click it to store it in Keychain.
Export the certificate’s private key into a p12 file in the same manner you did with the Push Notification Certificate.
As a result, you have a p12 file such as ios_development.p12.


# Configuring your backend

## Creating the Push Notification Certificate

(Tähän paste google docsista kohdat 1-6)
