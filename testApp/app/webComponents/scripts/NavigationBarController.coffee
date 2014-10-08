angular
  .module('webComponents')
  .controller 'NavigationBarController', ($scope) ->
    $scope.showNav = ->
      document.querySelector('super-navigation-bar').setAttribute("style", "display: block;")

    $scope.hideNav = ->
      document.querySelector('super-navigation-bar').setAttribute("style", "display: none;")

    $scope.navBarTitle = "Title"

    $scope.setNavBarTitle = ->
      $scope.navBarTitle = "New title"

    $scope.removeNavBarTitle = ->
      $scope.navBarTitle = undefined


