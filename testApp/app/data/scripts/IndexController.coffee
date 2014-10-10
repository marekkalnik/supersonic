angular
  .module('data')
  .controller 'IndexController', ($scope, supersonic) ->
    $scope.dataChannelView = false
    $scope.createViewAndStart = ->
      view = supersonic.ui.view("data#channel")
      supersonic.ui.views.start(view, "dataChannelView").then( 
        (carsEditView) ->
          $scope.$apply ->
            $scope.dataChannelView = true
        (error) ->
          supersonic.logger.log "Could not start dataChannelView: #{JSON.stringify error}"
      )

    $scope.messagePublished = 0
    $scope.sendMessage = () ->
      supersonic.ui.views.find("dataChannelView").then( 
        (view) ->
          channel = supersonic.data.channel('dataChannelView')
          channel.publish "Hello there, DataChannelView!"
          $scope.messagePublished++
        (error) ->
          supersonic.logger.log "Could not send message via dataChannelView channel: #{error}"
      )

    $scope.openDataChannelView = () ->
      supersonic.ui.views.find("dataChannelView").then(
        (view) ->
          supersonic.ui.layer.push view
        (error) ->
          supersonic.logger.log "Could not push layer: #{error}"
      )

        