angular.module('todoApp.directives').directive('registrationsForm', ['SessionService', 'templateUrls', (SessionService, templateUrls) ->
  {
    restrict: 'A'
    templateUrl: templateUrls['sign_up']
    controller: ($scope) ->
      $scope.registration = SessionService.userRegistration

      $scope.errors = {}

      $scope.create = () ->
        $scope.registration.$save().success((data, status, xhr) ->
          $scope.errors = {}
          $scope.registration.clearFields()
          SessionService.signIn(data)
        ).error((data) ->
          $scope.errors = data
        )

  }
])