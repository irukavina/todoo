angular.module("todoApp.controllers").controller('SessionCtrl', ["$scope", '$route', 'SessionService', ($scope, $route, SessionService) ->
  $scope.email = SessionService.email

  $scope.isSignedIn = SessionService.isSignedIn

  $scope.signOut = ->
    SessionService.signOut()
    $route.reload()
])