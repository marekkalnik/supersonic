Promise = require 'bluebird'

{network} = require '../events'

module.exports = (steroids, log) ->
  bug = log.debuggable "supersonic.device.network"

  ###
   # @namespace supersonic.device
   # @name network
   # @overview
   # @description
   # Provides information about the network status of the device.
  ###
  ###
   # @namespace supersonic.device.network
   # @name whenOffline
   # @function
   # @apiCall supersonic.device.network.whenOffline
   # @description
   # Detect when the device goes offline.
   # @type
   # supersonic.device.network.whenOffline: (
   #   listen: Function
   # ) => unsubscribe: Function
   # @define {Function} listen A function that is fired when the device goes offline.
   # @returnsDescription
   # Returns an unsubscribe function that can be triggered to stop listening for offline events.
   # @define {=>Function} unsubscribe Stop listening for offline events.
   # @exampleCoffeeScript
   # unsubscribe = supersonic.device.network.whenOffline ->
   #   supersonic.ui.dialog.alert "Device is offline!"
   #
   # # Later on, we can unsubscribe and stop listening for offline events
   # unsubscribe()
   # @exampleJavaScript
   # var unsubscribe = supersonic.device.network.whenOffline( function() {
   #   supersonic.ui.dialog.alert("Device is offline!");
   # });
   #
   # // Later on, we can unsubscribe and stop listening for offline events
   # unsubscribe();
  ###
  whenOffline: (listen) ->
    network
      .filter((online) -> !online)
      .onValue listen

  ###
   # @namespace supersonic.device.network
   # @name whenOnline
   # @function
   # @apiCall supersonic.device.network.whenOnline
   # @description
   # Detect when the device goes online.
   # @type
   # supersonic.device.network.whenOnline: (
   #   listen: () =>
   #     whenOnline?: Function
   # ) => unsubscribe: Function
   # @define {Function} listen A function that is fired when the device goes online. Additionally, the `listen` function can return a `whenOffline` function.
   # @define {Function} whenOffline A function that gets triggered when the device goes back offline. This is useful for e.g. chaining event streams.
   # @returnsDescription
   # Returns a function given as a parameter when the device goes online.
   # @define {=>Function} unsubscribe Stop listening for online events.
   # @exampleCoffeeScript
   # unsubscribe = supersonic.device.network.whenOnline ->
   #   supersonic.ui.dialog.alert "Device is online!"
   #   ->
   #     supersonic.ui.dialog.alert "Device is offline!"
   #
   # # Later on, we can unsubscribe and stop listening for online events
   # unsubscribe()
   # @exampleJavaScript
   # var unsubscribe = supersonic.device.network.whenOnline( function() {
   #   supersonic.ui.dialog.alert("Device is online!");
   #   return function() {
   #     supersonic.ui.dialog.alert "Device is offline!"
   #   }
   # });
   #
   # // Later on, we can unsubscribe and stop listening for online events
   # unsubscribe();
  ###
  whenOnline: (f)->
    whenOnline = null
    network
      .map((status) ->
        if status
          ->
            whenOnline = f()
        else
          ->
            whenOnline?()
            whenOnline = null
      )
      .onValue (notify) ->
        setTimeout notify, 0
