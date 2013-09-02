angular.module('todoApp.directives').directive('sessionsForm', ['SessionService', 'templateUrls', (SessionService, templateUrls) ->
  {
    restrict: 'A'
    templateUrl: templateUrls['sign_in']
    scope: true,
    controller: ($scope) ->
      $scope.session = SessionService.userSession

      $scope.errors = {}

      $scope.create = () ->
        $scope.errors = {}
        $scope.session.$save().success((data, status, xhr) ->
          $scope.session.clearFields()
          SessionService.signIn(data)
        ).error((data) ->
          $scope.errors = data
        )
  }
])