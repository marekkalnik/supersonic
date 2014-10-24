---
layout: docs_first_mile
title: Supersonic Documentation
header_title: Supersonic First Mile
header_sub_title: Learn how to build your first app in 5 minutes.
section_id: your-first-app-in-5-minutes
subsections:
  - name: Overview
  - name: Installation
  - name: Creating a New Project
  - name: Connecting Your Device
  - name: Making Changes
  - name: Debugging
  - name: Distributing Your App
---

<section class="docs-section" id="overview">
## 2.1 Overview

In this tutorial, we will be going through the few simple steps needed to get an app running on your device.

The end result will look like this:

<img src="http://placehold.it/600x300">
</section>

<section class="docs-section" id="installation">
## 2.2 Installation

Before we move forward, you need to install the Steroids² tooling. Head on over to our [Install Wizard](https://academy.appgyver.com/installwizard) page and follow the instructions there.
</section>

<section class="docs-section" id="creating-a-new-project">
## 2.3 Creating a New Project

With your brand-new Steroids² CLI running, head on over to your terminal app of choice and create your first app. To do so, just type:

```bash
steroids create myProject
```

The Steroids² CLI will create a basic project in the `myProject/` folder and install some required dependencies like the `steroids.js` and `supersonic.js` libraries. Feel free to poke around for a little while, but the app structure will be better explained in a later chapter.
</section>

<section class="docs-section" id="connecting-your-device">
## 2.4 Connecting Your Device

Running your app is super-easy via the AppGyver Scanner. If you haven't done so yet, download the AppGyver Scanner for your Android or iOS device:

  - [AppGyver Scanner for iOS](https://itunes.apple.com/us/app/appgyver-scanner/id575076515?mt=8)
  - [AppGyver Scanner for Android](https://play.google.com/store/apps/details?id=com.appgyver.freshandroid)

Next, head back to the terminal to run your app. In your project folder (`myProject/` in this case), enter the following command:

```bash
steroids connect
```

###Connecting with an actual device

The Steroids² CLI will compile your project and then open up a new browser window with a prominently displayed QR code:

<img src="http://placehold.it/600x300">

Now, to run your app in a real device, all you have to do is open the AppGyver Scanner you downloaded previously and scan the displayed QR code. The Scanner app will then download the required files and start your app.

###Connecting with the iOS Simulator

>__Please notice:__
>We only support the iOS Simulator at the moment. Android development requires an Android device.

This step requires OS X and [Xcode 6.0](https://developer.apple.com/xcode/) or later to be installed.

Running the Simulator requires that you have started a Steroids server that is serving your project files. You already did this by running `steroids connect` in the terminal, but if you have since closed the connection, rerun the command.

Now, open the browser window from where you scanned the QR code with your device. If you have closed the browser window, you can re-open it by typing `qr` in the Steroids console. In the Connect window, next to the QR code you will have an option to launch the iOS Simulator. Press it and your app will boot up in the Simulator.

As you get more familiar with the platform, you will often want to launch the Simulator straight from the terminal. To do that, simply enter the following command in the Steroids² console:

```bash
simulator
```

The iOS Simulator will open and your app will load automatically.
</section>

<section class="docs-section" id="making-changes">
## 2.5 Making Changes

With your app up and running, we're ready to make some changes. Open the `myProject/app/common/views/index.html` file in your editor of choice and change the contents of the file to be:

```html
<div class="padding">
  <h1>Hello World!</h1>
</div>
```

###Basic app reload

After saving the file you still need to push the changes to the test device. To do so, simply go to the terminal window running `steroids connect` and press Enter. The Scanner app will then automatically reload the app and display the new content. Pretty handy, but we can actually do better.

###Faster development with livereload

You may have noticed that with your edit, the navigation bar disappeared from the app. Before we correct that mistake, let's quit the current `steroids connect` session by typing `q` and pressing Enter in the Steroids console. This will close the connection between the Steroids console and your device. Note that your app won't shut down, it just no longer receives updates from the Steroids console. Let's open a new instance of `steroids connect`, but this time, we'll give it a few arguments:

```
steroids connect --watch --livereload
```

The `--watch` argument tells the Steroids console to watch for changes in your project files and push any changes it detects automatically to your device. `--livereload` tells the console that, when possible, it should only push updates to the existing content in your app without prompting a full refresh. If you never quit the Scanner application on your device, it will probably detect the new `connect` instance and reload accordingly, but just to be safe, let's scan the newly generated QR code.

 - On Android, press the device's back button until the "Scan" screen comes up and then scan the code.
 - On iOS, tap and hold the screen with 3 fingers. This will open up a menu, from where you can choose "Scan another app", and then scan the code.

Now we're ready to re-add the navigation bar. To do so, open the `myProject/app/common/views/index.html` file again and add the following above the previously inserted `<div>` tag:

```html
<super-navbar>
  <super-navbar-title>
    Hello World
  </super-navbar-title>
</super-navbar>
```

Now, just save the file and take a look at your Scanner, it should update nearly instantly with a brand new navigation bar, without going through the "reloading" screen at all. You can change any of the basic HTML content like this and get instant results, but notice that changes to the project structure like new files or layout changes require a "full refresh" to take effect. To trigger a full change, type "r" in the Steroids console and press enter.
</section>

<section class="docs-section" id="debugging">
## 2.6 Debugging

You are bound to make some mistakes when you develop, so it's important to know how to handle them. Since we're working with a nearly empty app, we'll have to cheat a little here, but this exercise will save you a lot of trouble going forward. Let's make another change to `app/common/views/index.html`. Add the following to the end of the file:

```html
<script>
  throw new Error("Oh no, there's a bug in my app!")
</script>
```

Then, refresh your app (or let livereload handle it). At first glance nothing seems to be wrong, but problems aren't always immediately visible. Just to be sure, let's take a look at some of the logs that are available to us.

###Connect window

You may have already noticed that the browser window from where you scan the app's QR code contains a few different tabs, accesible from the top right corner of the window. Go to the "Logs" tab. If you've closed the window at some point, you can re-open it by typing `qr` in the Steroids console. Immediately you will notice a familiar looking message:

<img src="http://placehold.it/600x300">

It's the message from the custom Error we just created, along with some debugging information, such as the device and view the Error occured in. You can use the tools at the top of the window to filter messages and clear the current log. Now that we have made a note of the error, let's clear the log and try again. In `app/common/views/index.html`, remove the `<script>` tag and it's contents and save the file. After the app refreshes take another look at the "Logs" tab and you'll see that the error no longer occurs. Gongratulations, you've fixed your first bug!

###Platform specific debugging

- Safari Debugger
- Chrome Debugger
- Links to best practices
</section>

<section class="docs-section" id="distributing-your-app">
## 2.7 Distributing Your App

An app isn't much good if you can't share it with someone. While you're developing your app, you can share your progress easily with a Cloud QR code, which can be scanned and run by anyone with the link and access to the AppGyver Scanner. To generate your first Cloud QR, go to the "Cloud Settings" tab in the browser and deploy your app to the AppGyver Cloud. After deploying, you will see a QR code generated on-screen. This is a cloud-based version of your app, which you can scan and preview just like a normal app, but it is not connected to your local development environment, so any new changes you make after the deploy will not update to the cloud app.

 To share your progress with your friends or co-workers, click on the "open cloud share page", which will open a new browser tab with the share QR code. Now you can just copy and paste this url to anyone you want to take a look at your app.
</section>

##Done

In this section we've covered the basics of app development, by now you know how to:

  - Create a Steroids app
  - Edit your app
  - Use basic debugging tools
  - Share your app with others

With these skills, you're ready to start creating some real-world applications!
