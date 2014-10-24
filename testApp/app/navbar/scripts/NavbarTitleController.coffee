angular
  .module('navbar')
  .controller 'NavbarTitleController', ($scope) ->

    $scope.navbarTitle = "Title"

    $scope.setNavbarTitle = ->
      $scope.navbarTitle = "New title"

    $scope.removeNavbarTitle = ->
      $scope.navBarTitle = ""