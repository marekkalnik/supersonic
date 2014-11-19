---
layout: docs_ui
header_title: Rotations
header_sub_title: Learn how to make your app rotate to different rotations.
section_id: app
subsection_id: rotations
topics:
  - name: Setting Allowed Rotations via the Build Service
  - name: Setting Allowed Rotations via JavaScript
  - name: setAllowedRotations
    method: true
---

# Rotations

There are several cases where rotations come into play with your app. You might want to limit your app to a single rotation, or allow all of them. Alternatively, you might want to have e.g. a landscape-only modal slide on top of your app that is otherwise always in portrait mode.

<section class="docs-section" id="setting-allowed-rotations-via-the-build-service">
## Setting allowed rotations via the Build Service

iOS and Android really want rotations to be the same app-wide, and they're defined during the build phase. Thus, the way to set rotations is in the Build Service, on your app's Build Configuration page. The defaults will apply for all views in your app. (Note that a custom-built Scanner app will also have the same default rotations, which is useful for testing and development.)

### iOS

<img src="/img/ui-and-navigation/ios_rotation_settings.png" alt="iOS Rotation Settings">

Check all the orientations that apply, separately for iPhone and iPad.

### Android

<img src="/img/ui-and-navigation/android_rotation_settings.png" alt="Android Rotation Settings">

Select the orientation you want to use. See the [official documentation](http://developer.android.com/reference/android/R.attr.html#screenOrientation) for an explanation of the values.
</section>

<section class="docs-section" id="setting-allowed-rotations-via-javascript">
## Setting allowed rotations via JavaScript

The [supersonic.ui.screen.setAllowedRotations](#setallowedrotations) API call allows you to override the default allowed device orientations, affecting all app views. The exception is modals, for which you have to set the rotations separately.

</section>
<section class="docs-section" id="setallowedrotations">
{% assign method = site.data.supersonic.ui.screen.setAllowedRotations %}
{% include api_method.md method=method %}
</section>
