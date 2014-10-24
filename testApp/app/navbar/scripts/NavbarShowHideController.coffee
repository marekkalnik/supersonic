angular
  .module('navbar')
  .controller 'NavbarShowHideController', ($scope) ->

    $scope.showNavbar = ->
      document.querySelector('super-navbar').setAttribute("style", "display: block;")

    $scope.hideNavbar = ->
      document.querySelector('super-navbar').setAttribute("style", "display: none;")