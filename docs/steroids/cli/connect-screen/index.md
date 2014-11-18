---
layout: steroids_cli
header_title: Connect Screen
header_sub_title: Learn how to use the Steroids Connect Screen
section_id: connect-screen
parent_id: steroids
---

<section class="docs-section" id="overview">
# Connect Screen

The Steroids Connect Screen is your one-stop shop for app management and debugging. It opens up automatically in your default web browser when you start the Steroids Development Server by running `steroids connect` in your project folder.

You can also type `c` or `connect` in the Development Server console to open the Connect Screen, or simply navigate your browser to [http://connect.appgyver.com](http://connect.appgyver.com). Finally, running `steroids connect --no-connect-screen` will cause Steroids to not open the Connect Screen automatically.

The Connect Screen has five main views: Preview, Logs, Documentation, Build Settings and Data, which are accessible via the menu bar at the top of the page. Each of these views has it's own special purpose, let's take a look at a couple of them.

## Preview

The Preview screen shows the local QR code. Scan it with AppGyver Scanner to connect your app to test and develop your app on a mobile device.

Once you scan the QR code and the app loads, a connection is established between your device and the Steroids Development Server. The Connected devices list updates automatically to show your device (along with its name, Scanner version and platform).

Finally, there are buttons to launch the iOS Simulator (Mac OS X and Xcode 6 required) or the Android Genymotion emulator.

## Logs

When developing apps, you will inevitably have to debug your code at some point. There are of course many ways to do this (see the [Debugging index][debugging-guide] for more), but the Logs screen is a very useful tool for debugging purposes.

See the [Logging guide][logging-guide] for more information.

## Documentation

The Documentation screen provides quick links to our documentation (that's where you're now!), including API reference, guides and tutorials.

## Cloud Settings

The Cloud Settings screen will let you deploy your app to the AppGyver Cloud. After you have deployed your app, you will have access to [Supersonic Data][data-guide], [Build Settings][build-settings-guide] to create standalone builds, QR code sharing and more.

Clicking the *Deploy to Cloud* button will deploy your app to the cloud, and create a new file at `config/cloud.json`. Read more in the [Deploying to Cloud][deploying-to-cloud-guide] guide.

## Data

The Data screen is your management console for Supersonic Data. After you have deployed your app to the cloud (see the [guide][deploying-to-cloud-guide] for more), you can either connect your app to an existing backend or play around with the AppGyver Sandbox Database. Read more in the [Data Management][data-guide] section!
</section>

[build-settings-guide]: /steroids/build-service/build-settings/
[data-guide]: /supersonic/guides/data/
[debugging-guide]: /steroids/cli/debugging/
[deploying-to-cloud-guide]: /steroids/build-service/build-settings/deploying-to-cloud
[logging-guide]: /steroids/cli/debugging/logging/