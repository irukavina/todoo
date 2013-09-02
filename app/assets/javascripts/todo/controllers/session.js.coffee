angular.module("todoApp.controllers").controller('SessionCtrl', ["$scope", '$route', 'sessionService', ($scope, $route, sessionService) ->
  $scope.email = sessionService.email

  $scope.isSignedIn = sessionService.isSignedIn

  $scope.signOut = ->
    sessionService.signOut()
    $route.reload()
])