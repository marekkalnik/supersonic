---
layout: steroids_cli
header_title: Debugging on iOS
header_sub_title: Learn how to debug your apps on iOS.
section_id: debugging
subsection_id: debugging-on-ios
parent_id: steroids
---
<section class="docs-section" id="debugging-on-ios">
# Debugging on iOS

On iOS, all you need to master is the Safari Web Inspector – all iOS versions and devices supported by Supersonic also support it.

However, **the Safari Web Inspector requires OS X**. If you are developing on a Linux or Windows machine, your only option is unfortunately to use the [Connect screen][logging-guide], which only supports logging messages and errors, but is missing more robust tooling.

## Debugging with the Safari Web Inspector

Safari offers a very powerful Web Inspector tool for debugging your app. Apple doesn't allow the Web Inspector to be used on apps downloaded from the App Store (i.e. the regular AppGyver Scanner), so the debugging tools can currently be used only with the iOS Simulator or with [custom Debug Builds][debug-builds-guide].

The Safari Web Inspector is the only fully functional Web Inspector tool currently available for debugging Supersonic apps running on iOS, so we recommend using it whenever possible.

## Using the Safari Web Inspector

### With the iOS Simulator
The easiest way to use the Safari Web Inspector is with the iOS Simulator, where debugging is enabld by default. Open your Supersonic app in the iOS Simulator by typing `s` in the Steroids Development Server console.

### With a Physical Device

Alternatively, you can use a [Debug Scanner or Debug Ad Hoc build][debug-builds-guide] for debugging your app. After you have requested, downloaded and installed the Debug Scanner/Ad Hoc IPA, you need to enable Web Inspector for Safari on your **iOS device**. Go to *Settings* > *Safari* > *Advanced* and enable the *Web Inspector* option. Then, connect your device to your computer with a cable.

### Enabling the Safari Develop Menu
<p class="advanced-panel">
  <strong>Note:</strong> your desktop Safari must be version 6.1 or later. You'll need to restart your computer after updating Safari for the Web Inspector to work.
</p>

Next, enable Safari's developer tools. Open Safari's preferences by selecting *Safari* > *Preferences* from the top menu, go to the *Advanced* tab and check the *Show Developer* menu checkbox.

Now, you should see a *Develop* menu item in Safari's top menu bar. Open the *Develop* > *iPhone Simulator* (or your iOS device's name) menu, and you should see a list of WebViews currently open in your app. (`contextmenu.html`, `loading.html` and `background.html` are used internally by Supersonic.)

You can also skip the Safari menu altogether. When in the `steroids connect` prompt, you can use `d` or `debug` command to get a list of currently open WebViews in the iOS Simulator. The command takes an argument like `d views/banana/index.html` to open the Safari Web Inspector for given WebView. Partial file/path names work also, so if you have an open WebView at `views/car/index.html` path you can simply write e.g. `d car/ind`.

If you cannot see any WebViews in your Safari Develop menu, restarting your computer might help.

### Inspecting a WebView

Select a WebView in your app. You now have direct Web Inspector access to it. You can edit the DOM and use the JavaScript console. The console also displays errors and `console.log` output.

If you type in `window.location.reload();` or press **CMD + R**, the WebView reloads itself, which allows you to see network requests and possible console errors that happen when the WebView loads.

You can even debug JavaScript by inserting breakpoints: open a `.js` file in the Safari Web Inspector (e.g. from the *Resource* tab) and click on the line numbers to insert break points. Then, reload the WebView. JavaScript execution will pause at the breakpoints, and the *Debug* tab shows the current call stack.

When using [LiveReload][livereload-guide], the Web Inspector windows are kept open when the app refreshes. However, if you disable LiveReload with the `--no-livereload` flag or initiate a full refresh by running `r` or `refresh` in the Steroids Developer Sever Console, all open Safari Web Inspector windows are unfortunately closed. You need to manually re-open them after the app has reloaded.
</section>
[debug-builds-guide]: /steroids/build-service/build-settings/building-a-debug-build/
[livereload-guide]: /steroids/cli/steroids-cli/local-development-flow/
