supersonic = require './core'
superscope = require './angular/superscope'
supersonicHelpers = require './angular/helpers'
supersonicDevice = require './angular/device'

module.exports = (angular) ->
  superscope(angular)
  supersonicHelpers(angular)
  supersonicDevice(angular)

  angular
    .module('supersonic', [
      'supersonic.helpers'
      'supersonic.superscope'
      'supersonic.device'
    ])
    .service('supersonic', (supersonicDevice, qifyAll) ->
      {
        logger: qifyAll supersonic.logger
        debug: qifyAll supersonic.debug
        app: qifyAll supersonic.app
        media: qifyAll supersonic.media
        notification: qifyAll supersonic.notification
        device: supersonicDevice
        ui: supersonic.ui
        date: supersonic.data
      }
    )
