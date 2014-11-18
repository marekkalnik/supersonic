---
layout: docs_first_mile
title: Supersonic Documentation
header_title: Supersonic First Mile
header_sub_title: Learn how to build your first app in 5 minutes.
section_id: first-mile
subsections:
  - name: Overview
  - name: Installation
  - name: Creating a New Project
  - name: Connecting Your Device
  - name: Introduction to Native UI Components
  - name: Making Changes
  - name: Navigating to Another View
  - name: Done!
---


<section class="docs-section" id="overview">
## Overview

In this tutorial, we will be going through the few simple steps needed to get an app running on your device. This section will take 5-10 minutes to complete, and you will learn:

  - How to create a new Supersonic application
  - That Supersonic apps mix native and HTML UI components in an awesome way
  - How to make changes to your Supersonic application
  - How to navigate to different views in your app

</section>


<section class="docs-section" id="installation">
## Installation

Before we move forward, you need to install the Steroids² tooling. Head on over to our [Install Wizard](https://academy.appgyver.com/installwizard) page and follow the instructions there.
</section>


<section class="docs-section" id="creating-a-new-project">
## Creating a New Project

With your brand-new Steroids² CLI running, head on over to your terminal app of choice and create your first app. To do so, just type:

```bash
steroids create myProject
```

You will then be prompted to make some selections regarding your project type. To follow this tutorial, choose Multi-Page application (MPA) and CoffeeScript for your project configuration. Using these defaults, your project will utilise `Angular.js` to create the MPA structure and create your project's script files using CoffeeScript.

>Note: Even though we recommend using Angular, Supersonic is framework agnostic. If you prefer a different framework, choose Single-Page application when prompted for application type, and create the app structure yourself.

The Steroids² CLI will create a basic project in the `myProject/` folder and install some required dependencies like the `steroids.js` and `supersonic.js` libraries. Feel free to poke around for a little while, but the app structure will be better explained in a later chapter.
</section>


<section class="docs-section" id="connecting-your-device">
## Connecting Your Device

Running your app is super-easy via the AppGyver Scanner. If you haven't done so yet, download the AppGyver Scanner for your Android or iOS device:

  - [AppGyver Scanner for iOS](https://itunes.apple.com/us/app/appgyver-scanner/id575076515?mt=8)
  - [AppGyver Scanner for Android](https://play.google.com/store/apps/details?id=com.appgyver.freshandroid)

Next, head back to the terminal to run your app. In your project folder (`myProject/` in this case), enter the following command:

```bash
steroids connect
```

This starts the Steroids Development Server. Among other things, it ensures that changes you make to your project are displayed in the actual devices.

### Connecting with an Actual Device

After compiling your project, the Steroids CLI will open up the Connect Screen in a new browser window. The Connect Screen has plenty of features, but for now, focus on the QR code that is shown on the first page:

<img src="/img/tutorial/Steroids_connect_index.png" style="width:75%;">

*Connect screen QR code.*

To run your app on a real device, all you have to do is open the AppGyver Scanner you installed previously and scan the displayed QR code. The Scanner app will then download the required files, establish a connection with the Steroids Development Server and start your app.
</section>


<section class="docs-section" id="introduction-to-native-ui-components">
## Introduction to Native UI Components
<img src="/img/tutorial/example_app_index.png" style="width:25%;">

*A fresh Supersonic project running on a device.*

The app starts in the view pictured above. Most of the content on the screen is just plain HTML and CSS. However, the top and bottom of the screen contain native components: a **native navigation bar** and a **native tab bar**.

Try rotating your device to see how the components smoothly realign themselves. You can rest assured the components stay in their correct places no matter what!

<img src="/img/tutorial/example_app_rotated.png" style="width:75%;">

*The native components realign themselves when the device is rotated.*

The native components also mean that we don't have to use any JavaScript hacks for scrolling. Try scrolling the view: it's smooth as butter, and if you scroll past the edge of the page, you get the native effects: rubber-band on iOS and the blue highlight on Android.

Next, try switching between the tabs. As you can see, the view changes instantaneously. This is possible because each tab is its own HTML document (wrapped inside its own WebView "browser" instance – more on this later), and switching between them is handled by native UI code.

The tabs live on even when they're not active. Go to the Settings tab, change the position of some of the sliders, and scroll down a bit. Switch to the Index tab and back again. The state is maintained perfectly, because nothing is done to the Settings tab itself – it is just hidden from view by the native UI code.
</section>


<section class="docs-section" id="making-changes">
## Making Changes

With your app up and running, we're ready to make some changes. Open the `myProject/app/example/views/gettin-started.html` file in your editor of choice. Find the `<super-navbar>` element and change the title text:

```html
<super-navbar>
  <super-navbar-title>
    Hello World!
  </super-navbar-title>
</super-navbar>
```
Save the file. The Steroids Development Server automatically notices that a file has changed and refreshes your project. The app will reload itself, after which you'll see the navigation bar update with your new title.
</section>


<section class="docs-section" id="navigating-to-another-view">
## Navigating to Another View

Below the `<super-navbar>` element, you will notice two buttons wrapped by another custom HTML element, `<super-navigate>`. The `<super-navigate>` element provides an easy way for you to declaratively set up the navigation structure of your app: when any of its child elements (the `<button>` in this case) are tapped, the app will navigate to the target view. (In this case, the target view is determined by the `view-id` attribute – you'll learn more about this in the following tutorials!)

Try it out! Tap either of the buttons on your device. You will see the new view animate into view, and a back button appear on the navigation bar.

The new view, again, is running inside its own native WebView container, so the view below will continue to happily exist, execute JavaScript and maintain state. The navigation stack is maintained automatically by the native side. Clicking on the back button will animate the view away and reveal the original view beneath.

For further reading on the navigation bar or the `<super-navigate>` element, see the following guides:

  - [Navigation Bar][nav-bar]
  - [super-navigate][super-navigate]

</section>


<section class="docs-section" id="done">
## Done!

In this section we've covered the basics of Supersonic App Development. By now you know:

  - How to create a new Supersonic application
  - That Supersonic apps mix native and HTML UI components in an awesome way
  - How to make changes to your Supersonic application
  - How to navigate to different views in your app

With these skills, you have grasped the core of developing Supersonic apps! Once you're ready, dive into the [Second mile][second-mile] tutorial to learn more essential skills, like debugging your app, as well as a deeper insight into how a Supersonic app really works.
</section>

[cli-dev-flow]: /steroids/cli/steroids-cli/local-development-flow/
[nav-bar]: /supersonic/guides/ui/native-components/navigation-bar
[super-navigate]: /supersonic/guides/navigation/declarative-navigation
[second-mile]: /supersonic/tutorial/second-mile
