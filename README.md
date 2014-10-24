SUPERSONIC
==========

<iframe width="420" height="315" src="//www.youtube.com/embed/kKO9h-gG4Qg" frameborder="0" allowfullscreen></iframe>

[![Build Status](http://img.shields.io/travis/AppGyver/supersonic/master.svg)](https://travis-ci.org/AppGyver/supersonic)
[![Dependency Status](http://img.shields.io/david/AppGyver/supersonic.svg)](https://david-dm.org/AppGyver/supersonic)
[![Coverage Status](https://img.shields.io/coveralls/AppGyver/supersonic.svg)](https://coveralls.io/r/AppGyver/supersonic)

Supersonic HTML5 app development on [Steroids](http://www.appgyver.com/steroids). CSS forked from [Ionic](https://github.com/driftyco/ionic/), with love.

## Supersonic - simplifying your HTML5 apps

AppGyver Steroids provides a wonderful layer for integrating your HTML5 application with native device capabilities. What we found from developing applications on Steroids is that you need more. Supersonic delivers the missing pieces: you'll be able to write HTML using default CSS components that are delightful to look at, use Web Components that map your HTML to fully native interfaces, and access native APIs with more ease than ever.

*Supersonic is framework agnostic.* It's a library consisting of CSS, Javascript and Web Components, which you can use with your framework of choice. However, Supersonic comes with a bundle that integrates with [Angular.js by Google](https://angularjs.org/) for even more awesomeness.

### Getting started

Supersonic ships with compiled Javascript, CSS and Web Component assets, along with a [great icon pack](http://ionicons.com/). You can get started with them with one line of code in your existing HTML5 application. New Steroids apps will have Supersonic from the get-go.

The easiest way to get Supersonic for your existing app is to install it as a [bower](http://bower.io/) dependency:

    bower install https://supersonic-backdoor:103944e9fd881b4de88536ab5529a30c387a93bd@github.com/AppGyver/supersonic-bower.git --save

Your Steroids application will now have `bower_components/supersonic` set up. Having your application use the library is one line of code.

    <script src="/components/supersonic/supersonic.js"></script>

You don't need to include the Javascript, CSS and Web Components separately, unless you really want to.

### Usage

Here's a sample of what Supersonic can do. Try this with your app on Steroids:

    <super-navbar>
        <super-navbar-title>Wow! It's mach 1!</super-navbar-title>
    </super-navbar>

Pow, there's a native navigation bar and you didn't have to write a line of Javascript.

For the rest of the story, check out the [Supersonic manual](http://supersonic.testgyver.com/docs).

## Development

### Getting started

Installing dependencies:

    npm install

Running tests:

    grunt test

For a test-and-watch-for-changes loop, use:

    grunt dev

For a build-and-watch-for-changes loop, use:

    grunt build watch:build

### Running testApp and testSpecApp

Running testApp and testSpecApp requires [devroids](https://github.com/AppGyver/devroids)

* Clone [devroids](https://github.com/AppGyver/devroids) repo, install its dependencies (npm install) and run `npm link`.
* Use devroids as you would use steroids.

### Generating documentation

Supersonic documentation is generated in a two-step process. A grunt task extracts metadata from source files. The docs are then presented along with the metadata by a jekyll server.

    gem install jekyll
    grunt compile-docs
    cd docs
    jekyll serve
    open http://localhost:4000/api

### Publishing to bower

This repository is set up with [Travis CI](https://magnum.travis-ci.com/AppGyver/supersonic). On each push to a branch that has passing unit tests, the continuous integration server will prepare a bower distributable version. That distributable will be deployed to [supersonic-bower](https://github.com/AppGyver/supersonic-bower) in an identically named branch, where it is installable via bower.

In other words, publishing is automatic. You don't need to do anything.

#### Tagging releases

What the publication process doesn't do yet, is handle semver updates and tagging. This is done manually for the source repo like this.

Update version tags in:

    package.json
    bower.json

Tag git version:

    git commit -m "x.y.z" && git tag "vx.y.z"

Publish:

    git push origin master --tags

Note that tags will not go through to supersonic-bower yet.
