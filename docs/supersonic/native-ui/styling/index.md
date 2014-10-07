---
layout: "docs_home"
section_id: native-ui
subsection_id: styling

title: Supersonic.js
header_sub_title: Tap into the native layer with the Supersonic.js library
---

# Styling native elements with Pixate

Superonic utilises Pixate to allow developers to style native iOS elements like any other part of their app. For Steroids apps this means control over the styling of native UI elements like the navigation and tab bars, which would be out of reach for regular CSS styling. Pixate Freestyle CSS is "full CSS" with the exception of not supporting pseudo-elements and a few minor differences which we will go over.

## Application Structure

Let's begin with an overview of a Freestyle-based application.  At application start-up, Freestyle looks for your application's CSS in a file named `default.css`, which is located in `www/native-styles/`. The default.css file can include other CSS files by using `@import`.

## CSS Media Queries

`@media` rules use CSS media queries to conditionally apply styles for different devices, screen resolutions, and orientations.

The following media expressions are allowed:

*   orientation: portrait | landscape
*   device: ipad | iphone | ipad-mini
*   device-width: <number> | <length>
*   min-device-width: <number> | <length>
*   max-device-width: <number> | <length>
*   device-height: <number> | <length>
*   min-device-height: <number> | <length>
*   max-device-height: <number> | <length>
*   scale: <number>
*   min-scale: <number>
*   max-scale: <number>

Media types (e.g., 'print') are not supported.  Use 'and' to join multiple media expressions.

Below are example uses of the `@media` rule:

```css
/* Rule sets apply only when the device is in portrait orientation */
@media (orientation:portrait) { }

/* Rule sets apply if the device's height (ignores orientation)
 is at least 1000 pixels and if the device has a retina display. */
@media (min-device-height:1000px) and (scale:2) { }

/* Apply rules to iPad Mini in landscape mode. */
@media (orientation:landscape) and (device:ipad-mini) { }
```


The iPad-Mini form factor is not supported in the simulator so it appears as an iPad in the simulator.

Finally, note that CSS does not support `@import` statements within `@media` rules.


## Importing Style Sheets

The `@import` rule allows importing style rules from other style sheets.  The `@import` statement must be followed by a URL that is relative to the `/www` folder.

```css
@import url("style.css")
@import "style.css"
```

Note that the `@import` does not support the CSS3 `@media` rule for specifying conditional style sheets or alternative style sheets. Also `@import` is not supported within an `@media` statement.  This restriction is silently enforced.


## Media Assets

Media assets are accessed using the url function and must be contained within the Application's bundle or on the device filesystem. Resources in the application bundle can be accessed using bundle://, files on the device are acessessed using file://,  and resources in the device documents folder can be accessed using documents://.  If no protocol is specified, the resources will be searched for first in the documents folder then in the resource bundle.

```css
/* search in documents folder and application bundle for resource */
background-image:    url(star.svg);

/* search for resource in a subfolder of Documents */
background-image:    url(documents://myResources/star.svg);

/* search for resource in a subfolder of  */
background-image:    url(file://images/star.svg);

/* search for resource in application bundle */
background-image:    url(bundle://star.svg);
```

## Runtime Configuration

The Freestyle engine allows you to customize some of its behavior, using CSS and a custom configuration element. You can access the configuration element by referencing it with the `freestyle-config` selector. For example:

```css
freestyle-config {
  parse-error-destination: console;
  cache-styles: auto;
  image-cache-count: 100;
}
```

In the example above, adding this snippet to `default.css` would send parse errors to the console, set up default cache settings, and bump the image cache count to 100 images.

### Configuration Properties

- _parse-error-destination_: `none` or `console`. Setting it to `console` displays any parse errors in your project's CSS in the XCode console during debugging. The default value is `none`.

- _cache-styles_: `auto`, `none`, `all`, `minimize-styling`, and `cache-images`. Used to toggle caching and to set limits for those caches. This property accepts a comma-delimited list of the preceding values. Values are processed in order and are accumulated. `auto` is the same as `minimize-styling, cache-images`. `minimize-styling` tries to prevent styling of an element if its styling has not changed. `cache-images` caches images generated during styling to avoid unnecessary rendering on future stylings and to generally increase styling speeds. The default (and recommended) value is `auto`.

- _image-cache-count_: [number](/pixate-freestyle-ios/style-reference/values.html#number). Determines how many images we be retained in the image cache, assuming it has been turned on with `cache-styles`. If this is set to `0`, then there will be no upper limit to how many images live in the cache. The default value is `10`.

- _image-cache-size_: [number](/pixate-freestyle-ios/style-reference/values.html#number). Determines how many bytes of image data are retained in the image cache. A value of `0` indicates that there is no upper limit to how many bytes can live in the cache. Note that `image-cache-count` will still be honored. The default value is `0`.