---
layout: docs_overview
parent_id: supersonic
section_id: native-bridge
---
<section class="docs-section" id="native-bridge">
# Supersonic Native API Bridge

In order to communicate between the HTML5 WebViews and the native code, there needs to be an "API bridge" that handles the communication.

The native bridge works in an async fashion. The API call is triggered and passed on to the native-side handler, which then triggers an appropriate callback. Supersonic then enhances this by wrapping the JavaScript APIs themselves in [promises][promises-overview].

The basic functionality of the native API bridge is demonstrated with the [supersonic.debug.ping][debug-api] function, which simply returns a "Pong!" string after having made a round trip to the native side.
</section>

[promises-overview]: /supersonic/guides/technical-concepts/promises
[debug-api]: /supersonic/api-reference/