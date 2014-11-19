Bacon = require 'baconjs'
Promise = require 'bluebird'
events = require '../../events'
channel = require '../../data/channel'


module.exports = (steroids, log) ->
  parameterBus = new Bacon.Bus

  viewObject = {
    params: parameterBus.toProperty(steroids?.view?.params)
    id: null
  }

  # find out if view is started or not (based on current URL matching)
  isStarted = ->
    new Promise (resolve, reject)->
      steroids.getApplicationState {},
        onSuccess: (state)->
          matches = (preload for preload in state.preloads when preload.URL is location.href)
          if matches.length
            # update .id
            viewObject.id = matches[0].id unless id?
            resolve()
          else
            reject()
        onFailure: ->
          reject(new Error("Could not get application state"))

  isStarted().then ->
    return unless viewObject.id?
    channelId = "view-params-#{viewObject.id}"
    unlisten = null

    viewChannel = channel(window)(channelId)
    parameterBus.plug viewChannel.inbound
  , ->
    console.log "View #{location.href} is not started, wont register channel"


  whenVisible = (f) ->
    whenHidden = null
    events
      .visibility
      .map((visible) ->
        if visible
          ->
            whenHidden = f()
        else
          ->
            whenHidden?()
            whenHidden = null
      )
      .onValue (notify) ->
        setTimeout notify, 0

  whenHidden = (f) ->
    whenVisible = null
    events
      .visibility
      .map((visible) ->
        if not visible
          ->
            whenVisible = f()
        else
          ->
            whenVisible?()
            whenVisible = null
      )
      .onValue (notify) ->
        setTimeout notify, 0


  ###
   # @namespace supersonic.ui.views
   # @name current
   # @overview
   # @description
   # Provides access to the current view and it's visibility state.
   #
   # ## Methods
   # * [whenVisible](/supersonic/api-reference/stable/supersonic/ui/views/current/whenVisible) – registers a listener that is triggered when the view becomes visible.
   # * [whenHidden](/supersonic/api-reference/stable/supersonic/ui/views/current/whenHidden) – registers a listener that is triggered when the view becomes hidden.
  ###

  viewObject.visibility = events.visibility
  ###
   # @namespace supersonic.ui.views.current
   # @name whenVisible
   # @function
   # @apiCall supersonic.ui.views.current.whenVisible
   # @description
   # Trigger a listener to when the current view becomes visible
   # @type
   # supersonic.ui.views.current.whenVisible: () => unsubscribe: Function
   # @define {Function} unsubscribe Stop listening for view visibility.
   # @usageCoffeeScript
   # stopListening = supersonic.ui.views.current.whenVisible ->
   #   supersonic.logger.debug "This view is now visible"
   #   stopListening()
   # @usageJavaScript
   # var stopListening = supersonic.ui.views.current.whenVisible( function() {
   #   supersonic.logger.debug("This view is now visible");
   #   stopListening();
   # });
  ###
  viewObject.whenVisible = whenVisible
  ###
   # @namespace supersonic.ui.views.current
   # @name whenHidden
   # @function
   # @apiCall supersonic.ui.views.current.whenHidden
   # @description
   # Trigger a listener to when the current view becomes hidden.
   # @type
   # supersonic.ui.views.current.whenHidden: () => unsubscribe: Function
   # @define {Function} unsubscribe Stop listening for view visibility.
   # @usageCoffeeScript
   # stopListening = supersonic.ui.views.current.whenHidden ->
   #   supersonic.logger.debug "This view is now hidden."
   #   stopListening()
   # @usageJavaScript
   # var stopListening = supersonic.ui.views.current.whenHidden( function() {
   #   supersonic.logger.debug("This view is now hidden");
   #   stopListening();
   # });
  ###
  viewObject.whenHidden = whenHidden

  # pass view object so that params & id can be changed from here
  viewObject
