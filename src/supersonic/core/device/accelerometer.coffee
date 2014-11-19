Promise = require 'bluebird'
Bacon = require 'baconjs'

{deviceready} = require '../events'

superify = require '../superify'

module.exports = (steroids, log) ->
  s = superify 'supersonic.device.accelerometer', log

  ###
   # @namespace supersonic.device
   # @name accelerometer
   # @overview
   # @description
   #  Provides access to the device's accelerometer. The accelerometer is a motion sensor that detects the change (delta) in movement relative to the current device orientation, in three dimensions along the x, y, and z axis.
  ###

  ###
   # @namespace supersonic.device.accelerometer
   # @name watchAcceleration
   # @function
   # @apiCall supersonic.device.accelerometer.watchAcceleration
   # @description
   # Returns a stream of acceleration updates.
   # @type
   # supersonic.device.accelerometer.watchAcceleration: (
   #   options?: {
   #     frequency?: Integer
   #   }
   # ) => Stream: {
   #   x: Number,
   #   y: Number,
   #   z: Number,
   #   timestamp: Date
   # }
   # @define {Object} options={} Optional options object.
   # @define {Integer} options.frequency=40 Update interval in milliseconds.
   # @returnsDescription A Stream of acceleration objects with the following properties.
   # @define {=>Object} acceleration Acceleration object.
   # @define {=>Number} acceleration.x Amount of acceleration on the x-axis. (in m/s^2)
   # @define {=>Number} acceleration.y Amount of acceleration on the y-axis. (in m/s^2)
   # @define {=>Number} acceleration.z Amount of acceleration on the z-axis. (in m/s^2)
   # @define {=>Date} acceleration.timestamp Creation timestamp for acceleration.
   # @usageCoffeeScript
   # supersonic.device.accelerometer.watchAcceleration options
   # @usageJavaScript
   # supersonic.device.accelerometer.watchAcceleration(options);
   # @exampleCoffeeScript
   # options =
   #   frequency: 60
   #
   # supersonic.device.accelerometer.watchAcceleration(options).onValue (acceleration) ->
   #   supersonic.logger.log(
   #     """
   #     Acceleration X: #{acceleration.x}
   #     Acceleration Y: #{acceleration.y}
   #     Acceleration Z: #{acceleration.z}
   #     Timestamp: #{acceleration.timestamp}
   #     """
   #   )
   # @exampleJavaScript
   # var options = {
   #   frequency: 60
   # }
   #
   # supersonic.device.accelerometer.watchAcceleration(options).onValue(function(acceleration) {
   #   supersonic.logger.log(
   #     "Acceleration X: " + acceleration.x + "\n" +
   #     "Acceleration Y: " + acceleration.y + "\n" +
   #     "Acceleration Z: " + acceleration.z + "\n" +
   #     "Timestamp: " + acceleration.timestamp
   #   );
   # });
  ###
  watchAcceleration = s.streamF "watchAcceleration", (options = {}) ->
    accelerationOptions =
      frequency: options?.frequency? || 40

    Bacon.fromPromise(deviceready).flatMap ->
      Bacon.fromBinder (sink) ->
        watchId = window.navigator.accelerometer.watchAcceleration(
          (acceleration) ->
            DOMTimeStamp = acceleration.timestamp
            acceleration.timestamp = new Date DOMTimeStamp
            sink new Bacon.Next acceleration
          (error) -> sink new Bacon.Error error
          options
        )
        ->
          window.navigator.accelerometer.clearWatch watchId

  ###
   # @namespace supersonic.device.accelerometer
   # @name getAcceleration
   # @function
   # @apiCall supersonic.device.accelerometer.getAcceleration
   # @description
   # Returns device's current acceleration.
   # @type
   # supersonic.device.accelerometer.getAcceleration: () =>
   #   Promise: {
   #     x: Number,
   #     y: Number,
   #     z: Number,
   #     timestamp: Date
   #   }
   # @returnsDescription A promise that is resolved with the next available acceleration data. Will wait for data for an indeterminate time; use a timeout if required.
   # @define {=>Object} acceleration Acceleration object.
   # @define {=>Number} acceleration.x Amount of acceleration on the x-axis. (in m/s^2)
   # @define {=>Number} acceleration.y Amount of acceleration on the y-axis. (in m/s^2)
   # @define {=>Number} acceleration.z Amount of acceleration on the z-axis. (in m/s^2)
   # @define {=>Date} acceleration.timestamp Creation timestamp for acceleration.
   # @usageCoffeeScript
   # supersonic.device.accelerometer.getAcceleration()
   # @usageJavaScript
   # supersonic.device.accelerometer.getAcceleration();
   # @exampleCoffeeScript
   # supersonic.device.accelerometer.getAcceleration().then (acceleration) ->
   #   supersonic.logger.log(
   #     """
   #     Acceleration X: #{acceleration.x}
   #     Acceleration Y: #{acceleration.y}
   #     Acceleration Z: #{acceleration.z}
   #     Timestamp: #{acceleration.timestamp}
   #     """
   #   )
   # @exampleJavaScript
   # supersonic.device.accelerometer.getAcceleration().then(function(acceleration) {
   #   supersonic.logger.log(
   #     "Acceleration X: " + acceleration.x + "\n" +
   #     "Acceleration Y: " + acceleration.y + "\n" +
   #     "Acceleration Z: " + acceleration.z + "\n" +
   #     "Timestamp: " + acceleration.timestamp
   #   );
   # });
  ###
  getAcceleration = s.promiseF "getAcceleration", ->
    new Promise (resolve) ->
      watchAcceleration().take(1).onValue resolve

  return {watchAcceleration, getAcceleration}
