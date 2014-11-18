---
layout: steroids_cli
header_title: Debugging
header_sub_title: Learn how to debug your apps.
section_id: debugging
subsection_id: logging
parent_id: steroids
---
<section class="docs-section" id="logging">
# Logging

Knowing what's going on in your app is crucial, especially when things start to go wrong. Supersonic provides powerful tools for logging what's going in your app. It also presents the logs to you in a clear format.

## Logs in Connect Screen

<img src="/img/tooling/connect-screen/logs-screen.png" width="900">

Let's first take a look at the Logs view in the Steroids [Connect Screen][connect-screen-guide], which is what you'll use to view your collected logs.

If you open the Logs view with any Supersonic app running, you'll probably see quite a bit of logs collected automatically.

### Filters

There are a variety of filtering options available in the top part of your screen. You can filter log messages by log level, device that logged the message, or even isolate a specific view for logging. You can clear active filters with the *Clear filters* button.

### Log Levels

Supersonic has four log levels. `debug` is the most verbose one, `info` is for general log messages, `warn` for when things are not working as intended and `error` for actual errors. When logging your own messages, it's a good idea to use a descriptive log level.

### Clearing Log Messages

Clearing log messages will remove all the currently visible log messages. Note that this only affects the Connect Screen – your logs will still be available in the `logs/` folder under your project (see the next section for more).

## Logging with `supersonic.logger`

The `supersonic.logger` API provides functions to log what's going on in your app. All four log levels are available. The `supersonic.logger.log` shorthand logs an `info` level message.

```javascript
// These are equivalent
supersonic.logger.log("Something semi-interesting just happened.")
supersonic.logger.info("Something semi-interesting just happened.")

supersonic.logger.debug("Doing something pretty detailed here.")

supersonic.logger.warn("Form was submitted with null value.")

supersonic.logger.error("Uh-oh, bad stuff happened!")
```

You can also log JavaScript objects directly:

```javascript
supersonic.logger.log(object);
```

Be liberal with your use of `supersonic.logger` – it's a great tool for debugging!

{% assign method = site.data.supersonic.logger.info %}
{% include api_method.md method=method %}

{% assign method = site.data.supersonic.logger.debug %}
{% include api_method.md method=method %}

{% assign method = site.data.supersonic.logger.warn %}
{% include api_method.md method=method %}

{% assign method = site.data.supersonic.logger.error %}
{% include api_method.md method=method %}

## Automatic Logging

Supersonic API calls and Web Components automatically log a bunch of stuff when they're executing. The automatic logs are logged with the `debug` log level.

Supersonic logs JavaScript errors automatically. Thus, if you have something like

```javascript
throw new Error("Oh no, there's a bug in my app!")
```

in your app, the result will be a corresponding `error`-level log line.



### Using `console.log`

You can still use `console.log`, but since it's only available if you've opened up a debug Web Inspector, `supersonic.logger` is preferred.
</section>
[connect-screen-guide]: /steroids/cli/connect-screen/