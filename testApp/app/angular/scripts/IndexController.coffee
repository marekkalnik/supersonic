angular
  .module('angular')
  .controller 'IndexController', ($scope, supersonic) ->

    $scope.currentId = null
    supersonic.bind $scope, "currentId"

    view = new supersonic.ui.View
      location: "angular#bindTest"
      id: "angularBindTest"
    view.start().catch ->
      # already started, don't care

    $scope.testBind = ->
      $scope.currentId = "#{Math.random()}"
