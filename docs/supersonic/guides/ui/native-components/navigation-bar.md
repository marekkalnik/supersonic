---
layout: docs_ui
header_title: Supersonic Native Components
header_sub_title: Learn how to utilize the native UI components provided by Supersonic to their fullest.
section_id: native-components
subsection_id: navigation-bar
topics:
  - name: Overview
  - name: super-navbar
    component: true
  - name: super-navbar-button
    component: true
  - name: Styling with CSS
  - name: Programmatic APIs
  - name: show
    method: true
  - name: hide
    method: true
  - name: update
    method: true
  - name: setClass
    method: true
  - name: setStyle
    method: true
  - name: setStyleId
    method: true
---

<section class="docs-section" id="overview">
# Navigation Bar Overview

The navigation bar is the native component that you'll probably interact with most when developing apps with Supersonic.

It is shown above the actual HTML view. Since it is implemented on the native side, it is always in the correct position – you don't have to worry about CSS classes for content or anything like that.

The navigation bar has two main functions:

  - It displays a **title** and optional **navigation bar buttons** for the current view
  - When applicable, it provides you with an automatic **back button** for going back in the navigation stack

To learn more about how the navigation stack works, please see the [Navigation Stack](/supersonic/guides/navigation/) guide.
</section>

<section class="docs-section" id="super-navbar">
## Using `<super-navbar>``

The `<super-navbar>` HTML element is a [web component](/supersonic/guides/technical-concepts/web-components/) that can be used to declaratively define the navigation bar in your app. Adding the `<super-navbar>` element on a page will display the navigation bar, and the `<super-navbar-title>` child element will allow you to define a title text for your view.

```html
<super-navbar>
  <super-navbar-title>
    Awesome App
  </super-navbar-title>
</super-navbar>
```

The `<super-navbar-title>` web component listens to changes in its text content and will update the navigation bar accordingly. Thus, you can use your favorite framework to make a dynamic title. For example, with AngularJS:

```html
<super-navbar>
  <super-navbar-title ng-bind="viewTitle"></super-navbar-title>
</super-navbar>
```

In the above example, changes to `$scope.viewTitle` will cause the navigation bar to update with the new content.
</section>

<section class="docs-section" id="super-navbar-button">
## Using `<super-navbar-button>`

You can also add native buttons to the navigation bar with the `<super-navbar-button>` web component. They have to be defined as children of `<super-navbar>`. The text content of the element defines the button text:

```html
<super-navbar>
  <super-navbar-button>
    Tap me
  </super-navbar-button>
  <super-navbar-title>
    Awesome App
  </super-navbar-title>
</super-navbar>
```

Tapping the button fires a click event on the `<super-navbar-button>` element that you can hook to with any framework. For example, with AngularJS:

```html
<super-navbar>
  <super-navbar-button ng-click="buttonTapped()">
    Tap me
  </super-navbar-button>
  <super-navbar-title>
    Awesome App
  </super-navbar-title>
</super-navbar>
```

In the above example, the function bound to `$scope.buttonTapped` will be called when the "Tap me" button is tapped.
</section>

<section class="docs-section" id="styling-with-css">
## Styling with CSS

Both the `<super-navbar>` and `<super-navbar-button>` elements can have `id`, `class` and `style` attributes that can be used to define how the navigation bar looks like. You can read more about the available CSS selectors in the [Styling Navigation Bar](/ui-and-navigation/styling-native-components/navigation-bar) guide.

However, there's a few caveats you should know.

### Navigation Bar Styles Apply to the Whole Navigation Stack

Currently (due to OS limitations that we are yet to overcome) the navigation bar is shared by the whole navigation stack.

This means that if you set a CSS class for the navigation bar in `index.html`, the same styles will be applied to the navigation bar in `show.html` too, and visa versa.

Navigation bar visibility also applies the whole navigation stack: if you set `<super-navbar style="display: none;">` or use the `supersonic.ui.navigationBar.hide()` API described below, the navigation bar will hidden in all views.

However, navigation bar buttons and title are unique for the view, so you don't have to worry about them overlapping.

Note that each navigation stack has its own navigation bar (tabs and modals have their own navigation stacks).
</section>

<section class="docs-section" id="programmatic-apis">
## Programmatic APIs

In addition to the web components, you can also interact with the navigation bar directly via JavaScript APIs.

Note that there are two namespaces:

  - `supersonic.ui.navigationBar` that deals with the navigation bar for the whole navigation stack, i.e. its visibility and CSS styles
  - `supersonic.ui.views.current.navigationBar` that deals with just the current view's navigation bar, i.e. its title and buttons

</section>

<section class="docs-section" id="show">
{% assign method = site.data.supersonic.ui.navigationBar.show %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="hide">
{% assign method = site.data.supersonic.ui.navigationBar.hide %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="update">
{% assign method = site.data.supersonic.ui.navigationBar.update %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="setclass">
{% assign method = site.data.supersonic.ui.navigationBar.setClass %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="setstyle">
{% assign method = site.data.supersonic.ui.navigationBar.setStyle %}
{% include api_method.md method=method %}
</section>

<section class="docs-section" id="setstyleid">
{% assign method = site.data.supersonic.ui.navigationBar.setStyleId %}
{% include api_method.md method=method %}
</section>
