Promise = require 'bluebird'
Bacon = require 'baconjs'

# (window) -> (level: string) -> (message: object) -> LeveledLogMessageEnvelope
logMessageEnvelope = (window) -> (level) -> (message) ->
  {
    message: try
        JSON.stringify message
      catch e
        e.toString()
    date: (new Date().getTime())
    level: level
    location: window.location.href
    screen_id: window.AG_SCREEN_ID
    layer_id: window.AG_LAYER_ID
    view_id: window.AG_VIEW_ID
  }

# (messageStream: Bacon.Bus(LogMessageEnvelope)) -> stopFlushing
startFlushing = (messageStream, sink) ->
  messageStream.onValue sink

# (object -> LogMessageEnvelope) -> {in: (object) -> (), out: Bacon.Bus(LogMessageEnvelope) }
logMessageStream = (toEnvelope) ->
  stream = new Bacon.Bus
  in: (message) -> stream.push message
  out: stream.map(toEnvelope)

module.exports = (steroids, window) ->
  defaultLogEndPoint = ->
    new Promise (resolve) ->
      steroids.app.host.getURL {},
        onSuccess: (url) ->
          resolve "#{url}/__appgyver/logger"

  shouldAutoFlush = ->
    new Promise (resolve, reject) ->
      steroids.app.getMode {},
        onSuccess: (mode) ->
          if mode is "scanner"
            resolve("Inside Scanner, autoflush allowed")
          else
            reject("Not in a Scanner app, disabling autoflush for logging")

  # (logEndPoint: string) -> (LogMessageEnvelope) -> XMLHttpRequest
  sendToEndPoint = (logEndPoint) -> (envelope) ->
    xhr = new window.XMLHttpRequest()
    xhr.open "POST", logEndPoint, true
    xhr.setRequestHeader "Content-Type", "application/json;charset=UTF-8"
    xhr.send JSON.stringify(envelope)
    xhr

  # (messageStream: Bacon.Bus(LogMessageEnvelope)) -> () -> Promise stopFlushing
  autoFlush = (messageStream) -> () ->
    shouldAutoFlush().then(
      ->
        defaultLogEndPoint().then (endPoint) ->
          startFlushing(messageStream, sendToEndPoint endPoint)
      (reason) ->
        console.log reason
    )

  do (toEnvelopeForLevel = logMessageEnvelope window) ->
    messages = new Bacon.Bus

    streamsPerLogLevel =
      info: logMessageStream toEnvelopeForLevel 'info'
      warn: logMessageStream toEnvelopeForLevel 'warn'
      error: logMessageStream toEnvelopeForLevel 'error'
      debug: logMessageStream toEnvelopeForLevel 'debug'

    messages.plug streamsPerLogLevel.info.out
    messages.plug streamsPerLogLevel.warn.out
    messages.plug streamsPerLogLevel.error.out
    messages.plug streamsPerLogLevel.debug.out

    return log = {
      # Don't expose messages, qify for angular goes haywire
      autoFlush: autoFlush messages
      log: streamsPerLogLevel.info.in

      # Wrap functions that return Promises so that start/end and rejection is logged
      debuggable: (namespace) -> (name, f) -> (args...) ->
        log.debug "#{namespace}.#{name} called"
        f(args...).then(
          (value) ->
            log.debug "#{namespace}.#{name} resolved"
            value
          (error) ->
            msg = if error?.errorDescription?
              error.errorDescription
            else
              JSON.stringify error

            log.error "#{namespace}.#{name} rejected: #{msg}"

            Promise.reject error
        )

      ###
       # @namespace supersonic
       # @name logger
       # @overview
       # @description Log messages directly to web console.
      ###

      ###
       # @namespace supersonic.logger
       # @name info
       # @function
       # @apiCall supersonic.logger.info
       # @description
       # Logs info level messages.
       # @type
       # supersonic.logger.info: (message: String)
       # @define {String} message Message to log.
       # @usageCoffeeScript
       # supersonic.logger.info("Just notifying you that X is going on")
       # @usageJavaScript
       # supersonic.logger.info("Just notifying you that X is going on");
      ###
      info: streamsPerLogLevel.info.in

      ###
       # @namespace supersonic.logger
       # @name warn
       # @function
       # @apiCall supersonic.logger.warn
       # @description
       # Logs warn level messages.
       # @type
       # supersonic.logger.warn: (message: String)
       # @define {String} message Message to log.
       # @usageCoffeeScript
       # supersonic.logger.warn("Something that probably should not be happening... is happening.")
       # @usageJavaScript
       # supersonic.logger.warn("Something that probably should not be happening... is happening.");
      ###
      warn: streamsPerLogLevel.warn.in

      ###
       # @namespace supersonic.logger
       # @name error
       # @function
       # @apiCall supersonic.logger.error
       # @description
       # Logs error level messages.
       # @type
       # supersonic.logger.error: (message: String)
       # @define {String} message Message to log.
       # @usageCoffeeScript
       # supersonic.logger.error("Something failed")
       # @usageJavaScript
       # supersonic.logger.error("Something failed");
      ###
      error: streamsPerLogLevel.error.in

      ###
       # @namespace supersonic.logger
       # @name debug
       # @function
       # @apiCall supersonic.logger.debug
       # @description
       # Logs debug level messages.
       # @type
       # supersonic.logger.debug: (message: String)
       # @define {String} message Message to log.
       # @usageCoffeeScript
       # supersonic.logger.debug("This information is here only for your debugging convenience")
       # @usageJavaScript
       # supersonic.logger.debug("This information is here only for your debugging convenience");
      ###
      debug: streamsPerLogLevel.debug.in
    }
