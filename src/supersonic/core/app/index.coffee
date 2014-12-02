Promise = require 'bluebird'

events = require '../events'

module.exports = (steroids, log) ->
  sleep: require("./sleep")(steroids, log)
  getLaunchURL: require("./getLaunchURL")(steroids, log)
  splashscreen: require("./splashscreen")(steroids, log)
  openURL: require("./openURL")(steroids, log)
  statusBar: require("./statusBar")(steroids, log)
  whenResumed: (listen) ->
    events.background
      .filter((paused) -> !paused)
      .onValue listen

  whenPaused: (listen)->
    events.background
      .filter((paused) -> paused)
      .onValue listen
