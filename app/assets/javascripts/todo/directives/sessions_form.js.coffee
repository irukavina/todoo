angular.module('todoApp.directives').directive('sessionsForm', ['sessionService', 'templateUrls', (sessionService, templateUrls) ->
  {
    restrict: 'A'
    templateUrl: templateUrls['sign_in']
    scope: true,
    controller: ($scope) ->
      $scope.session = sessionService.userSession

      $scope.create = () ->
        $scope.session.$save().success((data, status, xhr) ->
          $scope.session.clearFields()
          sessionService.signIn(data)
        )
  }
])