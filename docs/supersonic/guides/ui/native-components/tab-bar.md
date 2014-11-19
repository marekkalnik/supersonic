---
layout: docs_ui
header_title: Supersonic Native Components
header_sub_title: Learn how to utilize the native UI components provided by Supersonic to their fullest.
section_id: native-components
subsection_id: tab-bar
topics:
  - name: Overview
  - name: Defining tabs
  - name: Styling with CSS
  - name: Programmatic APIs
  - name: show
    method: true
  - name: hide
    method: true
  - name: update
    method: true
  - name: replace
    method: true
  - name: select
    method: true
  - name: updateCurrentTab
    method: true
  - name: setClass
    method: true
  - name: setStyle
    method: true
  - name: setStyleId
    method: true
---

<section class="docs-section" id="overview">
# Tab bar overview

The tab bar is a special bar anchored to the bottom of your app views that allows easy access to the main views of your application. The Supersonic tab bar is implemented in native code, so it is always situated below your view's HTML content and will not interfere with or be influenced by the positioning of the plain HTML elements.

Each tab maintains it's own layer stack, so all views and their contents (including the navigation bar) are separate from other tabs. To learn more about how the navigation stack works, please see the [Navigation Stack][nav-stack] guide.
</section>

<section class="docs-section" id="defining-tabs">
##Defining tabs

Tabs usually exist for the duration of the app's lifecycle and are relatively static in functionality, so it makes sense to define them before startup. Tabs can be defined in `/config/structure.coffee` with a special `tabs` array. The tab definition supports three properties: `title`, `id` and `location`:

```coffeescript
  tabs: [
    {
      title: "Index"
      id: "index"
      location: "example#getting-started"
    }
  ]
```

The `title` property is the name of the tab, displayed in the tab bar. Setting an `id` allows you to reference a specific tab by it's id when setting custom styles for the tab. Note that the tab icons are [defined in native CSS](#styling-with-css), so the `id` property is relevant for that use case.

The `location` property determines where your tab points to, and supports two kinds of syntax. In a default Supersonic app the syntax `<module-name>#<view-name>` works. In the above code example the defined tab will render the contents of the `getting-started.html` page in the `example` module. You can also use direct urls

```coffeescript
  tabs: [
    {
      title: "Index"
      id: "index"
      location: "http://localhost/app/example/getting-started.html"
    }
  ]
```

</section>

<section class="docs-section" id="styling-with-css">
## Styling with CSS

Both the tab bar and any tab items can be styled with CSS using the generic native CSS selectors `tab-bar` and `tab-bar-item`. You can also set style classes and ids for the tab bar as a whole, as well as use the tab ids defined in `/config/structure.coffee` to style specific tab items. You can read more about native styling for the tab bar in the [styling tab bar][styling-tab-bar] guide.
</section>

<section class="docs-section" id="programmatic-apis">
## Programmatic APIs

Although tabs are relatively static throughout an app's lifecycle, Supersonic provides a variety of APIs for modifying tabs on the fly, including the possibiliy to [show](#show), [hide](#hide) and [replace](#replace) the tab bar entirely. The full list of available APIs is below.
</section>

<section class="docs-section" id="show">
{% assign method = site.data.supersonic.ui.tabs.show %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="hide">
{% assign method = site.data.supersonic.ui.tabs.hide %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="update">
{% assign method = site.data.supersonic.ui.tabs.update %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="replace">
{% assign method = site.data.supersonic.ui.tabs.replace %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="select">
{% assign method = site.data.supersonic.ui.tabs.select %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="updateCurrentTab">
{% assign method = site.data.supersonic.ui.tabs.updateCurrentTab %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="setclass">
{% assign method = site.data.supersonic.ui.tabs.setClass %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="setstyle">
{% assign method = site.data.supersonic.ui.tabs.setStyle %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="setstyleid">
{% assign method = site.data.supersonic.ui.tabs.setStyleId %}
{% include api_method.md method=method %}
</section>

[nav-stack]:/supersonic/guides/navigation/
[styling-tab-bar]: /supersonic/guides/ui/styling-native-components/tab-bar