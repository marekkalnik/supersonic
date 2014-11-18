---
layout: steroids_build
header_title: Configuring custom plugins
header_sub_title: Learn how to configure plugins in the Build Service.
section_id: plugins
subsection_id: configuring-custom-plugins
parent_id: steroids
---
<section class="docs-section" id="configuring-custom-plugins">

# Configuring custom plugins

### Related Guides
* [Build settings for Android][android-build-config]
* [Build settings for iOS][ios-build-config]
* [Developing custom plugins][developing-custom-plugins]

The AppGyver Build Service, part of [AppGyver Cloud](http://cloud.appgyver.com) allows you to include custom Cordova plugins with your app. To develop locally with the plugins, you need to build (with the Build Service) a custom Scanner app that you download and install onto your device.

First follow the instructions for [building your app on iOS][ios-build-config] or [Android][android-build-config] and set up all the necessary files and settings for your app.

Then, in the Build Service's **Configure iOS/Android Build Settings** page for your app, find the **Plugins** field and include there an array of GitHub repos for the custom plugins you want to use, e.g.

```json
[
  {"source":"https://github.com/AppGyver/emailcomposer-plugin.git"}
]
```

If your plugin repo is private, please see [the section below](#private_repository_in_github).

Once you have added your custom plugins in the Build Service’s Configure iOS/Android Build Settings page, these plugins will be included in all types of builds. So, in addition to the Scanner builds, your custom plugins configurated in the Build Service will be included in Ad Hoc builds and App Store/Google Play builds as well.

**Note:** Steroids currently uses Cordova 3.5.0. The Cordova core features are included by default in Scanner and in all types of builds (Scanner, Ad Hoc, App Store, Debug Scanner, Debug Ad Hoc and Google Play) from the Build Service, so you don't need to include e.g. the [Vibration Plugin](https://github.com/apache/cordova-plugin-vibration) to use the Vibration API. The same applies to the other plugins installed by default. For the complete list of the plugins included by default, see [the Default plugins guide](https://academy.appgyver.com/categories/7-extending-with-plugins/contents/146-default-plugins).

Our Build Service supports two tools, [plugman](https://github.com/apache/cordova-plugman) and Cordova, for adding the plugin JavaScript files automatically to your custom builds. You need to check the plugin.xml file for each plugin you add to see which method they use:

* The `<asset>` element just includes the plugin's JavaScript file in your app. The file won't show up in the project structure, but will be available on the device. You need to manually include a `<script>` tag in your HTML to load the JavaScript file.
* The `<js-module>` element both includes the plugin's JavaScript file and also injects the relevant `<script>` tag into the DOM of all WebViews. Thus, **if this element is present, the plugin JavaScript is loaded automatically.**

A properly-coded Cordova plugin should not execute any code on load, but wait for an `init()` call or similar, so there's no harm in having the `<script>` tag injected to each view.

Certain plugins require you to pass variables to plugman. You can give these as a property of the individual plugin object:

```json
{
  "source":"https://github.com/my-awesome-organization/my-awesome-plugin.git",
  "variables": {
    "VARIABLE_NAME":"value",
    "SECOND_VAR":"second_value"
  }
}
```

There's also a guide available on [developing custom Cordova plugins][developing-custom-plugins].

## Developing locally with custom plugins

The way to use custom plugins in local development is to build a custom Scanner app using the AppGyver Cloud build service. You do need to set up the build config files as indicated in the [Building your app for iOS][ios-build-config]/[Building your app for Android][android-build-config] guides, including the custom plugins you want to use. Then, when you request a Scanner build, you get a Scanner app that includes the custom plugins you need (your actual project files won't be available in the Scanner build - it just functions as a Scanner).

You can then develop locally with the regular Steroids workflow, and you only need to access the build service to build your `.ipa`/`.apk` once you're ready to release your app (or you want to change your plugins).

Please note that all plugins are configured solely via the Build Service. This means that they aren't defined in the local `config.ios.xml` and `config.android.xml` files.

## <a id="private_repository_in_github"></a>Private repository in Github

You will need:

* A restricted account for your plugin
* A personal access token
* The URL to your plugin’s repository

If your plugin’s repository is not public, you need to provide build service with credentials.
Create a personal access token from *My account* > *Applications*.

**Please note:** A GitHub personal access token has full access to its account. This may pose a security risk since it grants anyone with the token full access to all its repositories. We recommend that you set up a restricted account which has a read-only access only to the repository of the plugin.

Once you have created the restricted account and the token, you can supply them along with the repository url. The format is the standard HTTP Basic Auth location string. For example with *myAccount* and *myToken*, the the complete plugin url would be:

```json
[
{"source":"https://myAccount:myToken@github.com/myAccount/awesome-plugin.git"}
]
```

Ensure that you did not supply any extra whitespace characters while copypasting the token.

## Known issues

On iOS, our plugins currently require [ARC support](https://developer.apple.com/library/ios/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html), so make sure the code compiles using ARC.
</section>

[android-build-config]: /steroids/build-service/build-settings/build-settings-for-android/
[ios-build-config]: /steroids/build-service/build-settings/build-settings-for-ios/
[developing-custom-plugins]: /steroids/build-service/plugins/developing-custom-plugins/
[plugin-xml-spec]: http://cordova.apache.org/docs/en/3.5.0/plugin_ref_spec.md.html