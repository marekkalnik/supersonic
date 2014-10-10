angular
  .module('data')
  .controller 'ChannelController', ($scope, supersonic) ->
    $scope.message = undefined
    supersonic.data.channel('dataChannelView').listen (message) ->
      $scope.message = message

