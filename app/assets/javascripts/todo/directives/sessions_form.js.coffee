angular.module('todoApp.directives').directive('sessionsForm', ['SessionService', 'templateUrls', (SessionService, templateUrls) ->
  {
    restrict: 'A'
    templateUrl: templateUrls['sign_in']
    scope: true,
    controller: ($scope) ->
      $scope.session = SessionService.userSession

      $scope.create = () ->
        $scope.session.$save().success((data, status, xhr) ->
          $scope.session.clearFields()
          SessionService.signIn(data)
        )
  }
])