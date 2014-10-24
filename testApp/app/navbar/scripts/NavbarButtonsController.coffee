angular
  .module('navbar')
  .controller 'NavbarButtonsController', ($scope) ->

    $scope.timesButtonClicked = 0

    $scope.navbarButtonCallback = ->
      $scope.timesButtonClicked++