angular.module('todoApp.controllers').controller('NewTaskCtrl', ['$scope', '$location', 'Tasks', ($scope, $location, Tasks) ->
  $scope.task = {
    priority: 0
  }
  $scope.title = 'Create task'
  $scope.commit = 'Create task'

  $scope.commitTask = ->
    Tasks.all().post($scope.task).then((task) ->
      $location.path('/')
    )


  $scope.cancel = ->
    $location.path('/')

])