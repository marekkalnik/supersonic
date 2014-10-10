Promise = require 'bluebird'
Bacon = require 'baconjs'

module.exports = (steroids, log) ->

  outboundBus = (name) ->
    bus = new Bacon.Bus

    bus
      .map (message) ->
        channel: name
        message: message
      .onValue (data) ->
        window.postMessage data

    bus

  inboundStream = (name) ->
    Bacon.fromEventTarget(window, "message")
      .filter((event) -> event.data.channel is name)
      .map((event) -> event.data.message)
  
  class Channel
    constructor: (@name) ->
      @outbound = outboundBus @name
      @inbound = inboundStream @name

    publish: (args...) =>
      @outbound.push args

    listen: (listener) =>
      @inbound.onValue (args) ->
        listener args...

  return (name)->
    return new Channel(name)