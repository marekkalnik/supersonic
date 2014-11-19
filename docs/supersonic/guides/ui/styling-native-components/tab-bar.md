---
layout: docs_ui
header_title: Styling Supersonic tab bar
header_sub_title: Learn how to style the native tab bar with CSS.
section_id: styling-native-components
subsection_id: tab-bar
topics:
  - name: tab-bar
  - name: tab-bar-item
---

<section class="docs-section" id="tab-bar">
# Styling the native tab bar

You can style the native tab bar by modifying the files in `app/common/native-styles/`. There are separate files for iOS and Android styling. The native tab-bar can be styled with the following selector:

```css
tab-bar {
}

```

To set the background color of your navigation bar, just add the `background-color` rule to the selector:

```css
tab-bar {
  background-color: #34495e;
}
```

Note that normal CSS inheritance applies, so if you set

```css
tab-bar {
  background-color: #34495e;
  color: #1abc9c;
}
```

the tab-bar icons and text will inherit the `color`rule.
# Child selectors
<section class="docs-section" id="navigation-bar-title">
## Styling the tab bar items

You can also style tab bar items specifically with the `tab-bar tab-bar-item` selector:

```css
tab-bar tab-bar-item {
  color: #e67e22;
  font-family: "Avenir";
  font-size: 10px;
}
```

Note that the tab icons are not affected by this styling. To style the tab icons, use the `tab-item` parent selector.

### Setting tab icons

Tab icons can be set via their ids. Usually, you will have defined tab ids in `config/structure.coffee`, which can then be referenced in the native CSS.

```css
tab-bar-item#index {
  background-image: url(icons/cog.svg)
}
```

You can also use the tab id to style the specific tab text:

```css
tab-bar-item#index {
  color: black;
}
```

Coloring the text of the selected tab can be done with the `:selected` pseudo-selector:

```css
tab-bar-item:selected {
  color:#1abc9c
}
```

The coloring of the selected tab's icon follows the color rule set by the `tab-bar` selector. Of course the text portion of the tab inherits the same rule, so for a clean look you should just use the `tab-bar` color rule.
</section>
