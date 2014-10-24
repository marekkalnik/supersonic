angular
  .module('app')
  .controller 'IndexController', ($scope, $timeout, $q, supersonic) ->
    $scope.successfulOpens = 0

    $scope.openURLTests = [
      {
        title: "Apple Maps maps:// (iOS)"
        options: "maps://?daddr=San+Francisco,+CA&saddr=cupertino"
      }
      {
        title: "Google Maps geo: (Android)"
        options: "geo:42,2?z=8"
      }
      {
        title: "Dolanz dolanz:// (should fail)"
        options: "dolanz://"
      }
    ]

    $scope.testOpenURL = (options) ->
      supersonic.app.openURL(options).then(
        () ->
          $scope.successfulOpens++
        (message) ->
          alert "Could not open URL! \n\n #{JSON.stringify(message)}"
      )

    $scope.launchURL = undefined

    $scope.getLaunchURLTests = [
      {
        title: "Get Launch URL"
      }
    ]

    $scope.testGetLaunchURL = (options) ->
      supersonic.app.getLaunchURL().then(
        (launchURL) ->
          $scope.launchURL = launchURL
        (message) ->
          alert "No launch URL available! \n\n #{JSON.stringify(message)}"
    )

    $scope.sleepDisabled = 0
    $scope.sleepEnabled = 0

    $scope.disableAndEnableSleepTests = [
      {
        title: "Disable and Enable Sleep"
      }
    ]

    $scope.testDisableAndEnableSleep = (options) ->
      supersonic.app.sleep.disable().then ->
        $scope.sleepDisabled++
        supersonic.app.sleep.enable().then ->
         $scope.sleepEnabled++

    $scope.splashscreenShown = 0
    $scope.splashscreenHidden = 0

    $scope.showAndHideSplashscreenTests = [
      {
        title: "Show Splashscreen and Hide in 5000 ms"
      }
    ]

    $scope.testShowAndHideSplashscreen = (options) ->
      supersonic.app.splashscreen.show().then(
        () ->
          $scope.splashscreenShown++
          $timeout ->
            supersonic.app.splashscreen.hide().then(
              () ->
                $scope.splashscreenHidden++
              (message) ->
                alert "Could not hide splashscreen! \n\n #{JSON.stringify(message)}"
            )
          , 5000
        (message) ->
          alert "Could not show splashscreen! \n\n #{JSON.stringify(message)}"
      )

    $scope.statusBarHidden = 0
    $scope.statusBarShown = 0

    $scope.hideAndShowStatusBarTests = [
      {
        title: "Hide and show status bar without params"
        options: null
      }
      {
        title: "Hide and show status bar with a string param"
        options: "light"
      }
      {
        title: "Hide and show status bar with an object param"
        options:
          style: "light"
      }
    ]

    $scope.testHideAndShowStatusBar = (options) ->
      supersonic.app.statusBar.hide().then(
        () ->
          $scope.statusBarHidden++
          supersonic.app.statusBar.show(options).then(
            () ->
              $scope.statusBarShown++
            (message) ->
              alert "Could not hide status bar! \n\n #{JSON.stringify(message)}"
          )
        (message) ->
          alert "Could not hide status bar! \n\n #{JSON.stringify(message)}"
      )

