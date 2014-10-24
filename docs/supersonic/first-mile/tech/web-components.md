---
layout: "docs_home"
version: "page.method"
versionHref: "/first-mile"
path: "tech/web_components"
section:
  name: "First mile"

title: "Supersonic Web Components"
header_sub_title: ""
---

#Supersonic Web Components

Supersonic utilizes [Web Components](http://www.html5rocks.com/en/tutorials/webcomponents/customelements/) to provide easily reusable HTML elements for your app. With web components it's possible to define new HTML elements that can be used in your code in a similar way to, for example, a `<div>` tag.

##Web Components and structuring your app

A very often repeated element in mobile applications is a navigation bar. One can be created with simple HTML, but it will lack the functionality and seamlessness of a native implementation. The Supersonic navigation bar however has the benefit of both approaches. To define a navigation bar just add

```html
<super-navbar>
  <super-navbar-title>
    I'm a native navigation bar!
  </super-navbar-title>
</super-navbar>
```

to the HTML file you want to include a navigation bar in. Now, if you run your project, you will see a navigation bar appear at the top of the app. It might seem a bit too simple to work, but there's actually a lot going on under the hood. The `<super-navbar>` element maps to the native interface and creates a fully native navigation bar in your app.
