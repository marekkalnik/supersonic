---
layout: steroids_cli
header_title: Local Development Flow
header_sub_title: Learn how the Steroids development flow works when you're working locally
section_id: steroids-cli
subsection_id: local-development-flow
parent_id: steroids
---
<section class="docs-section" id="local-development-flow">
# Local Development Flow

The Steroids tooling offers a smooth flow for local development, crafted to minimize the time you have to spend waiting for changes to be visible on your devices.

## Starting the Steroids Development Server

The backbone of local development is the Steroids Development Server. It is a web server that performs multiple functions – telling the AppGyver Scanner when to reload the app, serving your app files for local development, triggering the Grunt task to compile your project and more.

To start the Steroids Development Server, run in your Terminal window:

```
steroids connect
```

You'll see the `steroids-make` Grunt task compile your project files, after which the [Steroids Connect][connect-screen-guide] screen is opened in your Web Browser and the Development Server is ready to accept incoming connections.

## Connecting with the AppGyver Scanner App

Ensure that your mobile device and your computer are in the same Wi-Fi network (the phone's own Wi-Fi hotspot won't function). Then, scan the QR code shown in the Steroids Connect screen with the AppGyver Scanner app. Your mobile device will connect with the Development Server and load your app

## Auto-Detecting File Changes

The Steroids Development Server runs a file watcher by default. If you modify a file in your project, the Steroids Development Server will detect the change and reload your app to show the changes.

To disable the file watcher, run your app with the `--no-watch` flag:

```bash
steroids connect --no-watch
```

You can also exclude specific files by providing a list of comma-separated paths for the `--watchExclude` flag.

```bash
steroids connect --watchExclude=data/changesOften.json,data/alsoChangesOften.json
```
## How Your App Files Are Served

Before we dive into how your app reloads itself to show changes, it's important to understand how your app files are served. In [stand-alone builds][build-service-guide] of your app, all HTML, JS, CSS and other assets are included in the physical app bundle. The internal localhost web server running in the AppGyver Wrapper servers them from the device's hard drive.

When you are developing your app with AppGyver Scanner and the Steroids Development Server,  the app files are not transferred to the device's hard drive.

Instead, the Steroids Development Server serves your app's files via a local web server. In your app, requests to `localhost` are forwarded to the Development Server (instead of the app trying to fetch them from the device's hard drive).

Thus, each WebView fetches the HTML page (and all other assets) from the Development  Server before displaying it. This enables lightning-fast updates by allowing us to use LiveReload.

## Full Reload

A full reload is required when you make changes to your project's config files (`config/app.coffee` and `config/structure.coffee`). Since they are processed at app load, the whole app needs to be restarted after the changes. (Note that this doesn't mean you have to shut down the actual AppGyver Scanner app – we handle the restart process internally.)

When you change the files in the `config/` folder, a full reload is triggered. The current app state is discarded and a loading screen is shown. After a moment, the app starts with the modified configs.

You can initiate a full reload manually by pressing enter in the Steroids Development Console.

## Reloading your App with LiveReload

By default, the Steroids Development Server triggers a full reload every time your project files change. However, as noted above, this is only really required when the project's config files are changed. When you change regular project HTML, CSS and JS files, your app can refresh itself automatically. To have your app update instantly without any loading screens, you can use the `--livereload` switch.

```bash
devroids connect --livereload
```

This is caused by a special [LiveReload](http://livereload.com/) implementation in the AppGyver Scanner. In short, when a reload is requested, the Steroids Development Server sends a message to the Scanner app, which then instructs each WebView to reload itself.

Since the local web server on your computer is always serving the latest version of your app (the contents of the `dist/` folder, to be exact), the refreshed page will show your changes.

</section>

[build-service-guide]: /steroids/build-service/
[connect-screen-guide]: /steroids/cli/connect-screen/