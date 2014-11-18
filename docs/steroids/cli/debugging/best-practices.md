---
layout: steroids_cli
header_title: Debugging Best Practices
header_sub_title: Learn how to debug your apps the proper way.
section_id: debugging
subsection_id: best-practices
parent_id: steroids
---
<section class="docs-section" id="best-practices">
# Debugging best practices
Below is a collection of tips and best practices that we've found useful while debugging apps built with Supersonic and Steroids.

Make sure to read the following articles too, as they contain info about the basic tools you should use when debugging a Supersonic app.

* [Debugging on iOS][debugging-ios-guide]
* [Debugging on Android][debugging-android-guide]

## Use `supersonic.logger.log`

The `supersonic.logger.log` function behaves like `console.log`, but outputs directly to the [Connect Screen][connect-screen-guide]. Use it to ensure that a function call is actually reached, to see what values certain variables take, output error messages and so on.

Read more in the [Logging guide][logging-guide].

## Use alerts

`alert()` calls show up on the actual device, so they are useful to e.g. ensure that a function call has been reached. Note that alerts are blocking on mobile devices, meaning that JavaScript execution stops until the alert dialogue has been dismissed. This can be troublesome, so `console.log` is preferred in most cases.

## Use JSON.stringify on objects

By calling `JSON.stringify(myAwesomeObject)`, the object and its properties are transformed into a human-readable text string. Thus, e.g. `alert( JSON.stringify(myAwesomeObject) )` is a good way to see what's going on with an object.

## Use the JavaScript Console

While we're working hard to get every useful bit of information to the [Connect Screen][connect-screen-guide], some errors are still only visible in the JavaScript console – for example if Supersonic never loads properly. It's also useful to be able to evaluate arbitrary JavaScript calls to e.g. ensure that the API combo you're trying out really works.

Check out the [Debugging on iOS][debugging-ios-guide] and [Debugging on Android][debugging-android-guide] guides for information on how to access the JavaScript console on the respective platforms.

## Ensure that your HTML5 features are supported

Android (especially if you're using the platform WebView) is still lagging a bit behind iOS on the implementation of certain HTML5 features, and some of the cutting-edge stuff is not available at all on mobile devices.

The website [caniuse.com](http://caniuse.com) has good, up-to-date tables on what features are supported by which platforms. Be sure to check it out before you scratch your head wondering why e.g. `<input type="datetime-local">` just doesn't seem to work on your old Android device.
</section>

[connect-screen-guide]: /steroids/cli/connect-screen/
[debugging-android-guide]: /steroids/cli/debugging/debugging-on-android/
[debugging-ios-guide]: /steroids/cli/debugging/debugging-on-ios/
[logging-guide]: /steroids/cli/debugging/logging/
