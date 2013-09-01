angular.module('todoApp.directives').directive('registrationsForm', ['sessionService', 'templateUrls', (sessionService, templateUrls) ->
  {
    restrict: 'A'
    templateUrl: templateUrls['sign_up']
    controller: ($scope) ->
      $scope.registration = sessionService.userRegistration

      $scope.create = () ->
        $scope.registration.$save().success((data, status, xhr) ->
          sessionService.signIn(data)
        )

  }
])