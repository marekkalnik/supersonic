---
layout: "docs_home"
section_id: first-mile
subsection_id: migrating-existing-projects


title: "Migrate Steroids projects"
header_sub_title: ""
---

>__Note__: If you are a new user and are starting from scratch, don't worry about this guide. It is intended for existing users only. To continue learning about Supersonic, go create your first app with the help of the [Hello world guide]().

#Make your Steroids app Supersonic

Supersonic ships with compiled Javascript, CSS and Web Component assets, along with a great icon pack. You can get started with them with one line of code in your existing HTML5 application. New Steroids apps will have Supersonic from the get-go, but utilising Supersonic in your existing applications is also very simple

The easiest way to get Supersonic for your existing app is to install it as a bower dependency:

```bash
bower install https://supersonic-backdoor:103944e9fd881b4de88536ab5529a30c387a93bd@github.com/AppGyver/supersonic-bower.git --save
```

Your Steroids application will now have www/components/supersonic set up. Having your application use the library is one line of code.

<script src="/components/supersonic/dist/supersonic.bundle.js"></script>
You don't need to include the Javascript, CSS and Web Components separately, unless you really want to.

#Sneak peek into what you get

Since you are an existing Steroids user, you are most likely familiar with the `steroids.view.navigationBar` API. While handy, it does feel a little off having to define and set UI elements from purely JavaScript. In Supersonic, you can create a navigation bar like this:

```html
<super-navbar>
    <super-navbar-title>Wow! It's mach 1!</super-navbar-title>
</super-navbar>
```

Pow, there's a native navigation bar and you didn't have to write a line of Javascript. That's just the tip of the iceberg too, for the rest of the story, check out the [Supersonic manual](http://supersonic.testgyver.com/docs).
