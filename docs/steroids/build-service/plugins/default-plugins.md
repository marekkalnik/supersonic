---
layout: steroids_build
header_title: Default plugins
header_sub_title: See which plugins are included in your apps by default
section_id: plugins
subsection_id: default-plugins
parent_id: steroids
---
<section class="docs-section" id="default-plugins">

# Default plugins

## Related guides

- [Configuring custom PhoneGap plugins](/tooling/plugins/configuring-custom-plugins)

Steroids currently uses Cordova 3.5.0. The Cordova core features are included by default in [AppGyver Scanner for iOS](https://itunes.apple.com/us/app/appgyver-scanner/id575076515?mt=8) available on App Store and [AppGyver Scanner for Android](https://play.google.com/store/apps/details?id=com.appgyver.freshandroid&hl=en) available on Google Play, so you don't need a custom Scanner app to use them. The same applies to the other plugins included by default. The Cordova core features are also included by default in all types of builds from the AppGyver Build Service. The complete list of all the plugins included by default is shown below:

<div style="position:relative;padding-bottom:50%;width:100%">
<embed src="https://docs.google.com/spreadsheets/d/1kHGOjSWMUdXN-CmEW4iw9g8k45R9a_fj-39re1hmqUY/pubhtml?gid=0&single=true" style="position:absolute;top:0;left:0;width:50%;height:100%">
</div>

In addition, AppGyver Scanner for iOS available on the App Store includes [Cordova-SQLitePlugin](https://github.com/lite4cordova/Cordova-SQLitePlugin), [oauth-phonegap plugin](https://github.com/oauth-io/oauth-phonegap) and [Apache Cordova Facebook Plugin](https://github.com/AppGyver/phonegap-facebook-plugin). Please note that the Facebook plugin included in the App Store Scanner app can only be used with the [Add-ons Kitchensink app](https://github.com/AppGyver/addons-kitchensink). In order to use your own Facebook app, you need to build a custom Scanner app with your Facebook app id included in the Build Configuration in the Build Service (for further information see [the guide](/steroids/build-service/plugins/configuring-custom-plugins/)).

</section>