---
layout: docs_ui
header_title: Styling Supersonic Native Components
header_sub_title: Learn how to style native UI components with CSS.
parent_id: supersonic
section_id: styling-native-components
---

<section class="docs-section" id="overview">

# Overview

Steroids² utilises [Pixate Freestyle][pixate-home] to allow developers to style native UI elements like any other part of their app. For Steroids² apps this means control over the styling of native UI elements like the navigation and tab bars, which would be out of reach for regular CSS styling. Steroids² uses a customised version of Pixate with truly cross-platform functionality.

### Application Structure

Native styles are kept separate from the rest of your app's CSS, and are read from `/native-styles/ios.css` or `native-styles/android.css`, depending on which platform the app is running on.

### Selecting native elements

CSS rules are applied using a control's `element name`, `class`, `id` or other attributes. The `element name` is determined by the type of control.  For example, the native navigation bar has the `navigation-bar` element name.

### Using style classes and id's

For more fine-tuned control, you can define style classes and id's for all native elements, or even use in-line styles. You can set a class as an attribute in the HTML markup

```html
<super-navbar class="awesome-nav-bar">
  <!-- Navbar stuff here -->
</super-navbar>
```

or use the Supersonic API, e.g.

```coffeescript
supersonic.ui.navigationBar.setStyleClass("awesome-nav-bar")
```

For a more thorough look at the Supersonic styling APIs, head over to the docs:

  - [navigation bar][navigation-bar-api]
  - [tab bar][tab-bar-api]
  - [navigation bar button][navigation-bar-button-api]

### Media Assets

Media assets are accessed using the url function and must be contained within the Application's bundle or on the device filesystem. Resources in the application bundle can be accessed using bundle://, files on the device are acessessed using file://,  and resources in the device documents folder can be accessed using documents://.  If no protocol is specified, the resources will be searched for first in the documents folder then in the resource bundle.

    /* search in documents folder and application bundle for resource */
    background-image:    url(star.svg);

    /* search for resource in a subfolder of Documents */
    background-image:    url(documents://myResources/star.svg);

    /* search for resource in a subfolder of  */
    background-image:    url(file://images/star.svg);

    /* search for resource in application bundle */
    background-image:    url(bundle://star.svg);

### Importing Style Sheets

The `@import` rule allows importing style rules from other style sheets.  The `@import` statement must be followed by a URL that is relative to the `/dist` folder in a compiled app.

    @import url(style.css)
    @import "style.css"

Note that the `@import` does not support the CSS3 `@media` rule for specifying conditional style sheets or alternative style sheets. Also `@import` is not supported within an `@media` statement.  This restriction is silently enforced.

### Runtime Configuration

The Freestyle engine allows you to customize some of its behavior, using CSS and a custom configuration element. You can access the configuration element by referencing it with the `freestyle-config` selector. For example:

    freestyle-config {
      parse-error-destination: console;
      cache-styles: auto;
      image-cache-count: 100;
    }

In the example above, adding this snippet to `default.css` would send parse errors to the console, set up default cache settings, and bump the image cache count to 100 images.

### Configuration Properties

- _parse-error-destination_: `none` or `console`. Setting it to `console` displays any parse errors in your project's CSS in the XCode console during debugging. The default value is `none`.

- _cache-styles_: `auto`, `none`, `all`, `minimize-styling`, and `cache-images`. Used to toggle caching and to set limits for those caches. This property accepts a comma-delimited list of the preceding values. Values are processed in order and are accumulated. `auto` is the same as `minimize-styling, cache-images`. `minimize-styling` tries to prevent styling of an element if its styling has not changed. `cache-images` caches images generated during styling to avoid unnecessary rendering on future stylings and to generally increase styling speeds. The default (and recommended) value is `auto`.

- _image-cache-count_: [number][number-value]. Determines how many images we be retained in the image cache, assuming it has been turned on with `cache-styles`. If this is set to `0`, then there will be no upper limit to how many images live in the cache. The default value is `10`.

- _image-cache-size_: [number][number-value]. Determines how many bytes of image data are retained in the image cache. A value of `0` indicates that there is no upper limit to how many bytes can live in the cache. Note that `image-cache-count` will still be honored. The default value is `0`.

[Pixate-home]: http://www.pixate.com/
[navigation-bar-api]:/supersonic/api-reference/stable/supersonic/ui/navigationbar/
[tab-bar-api]:/supersonic/api-reference/stable/supersonic/ui/tabs/
[navigation-bar-button-api]:/supersonic/api-reference/stable/supersonic/ui/navigationbarbutton-class/

</section>
