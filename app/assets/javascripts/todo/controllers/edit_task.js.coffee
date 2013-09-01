angular.module('todoApp.controllers').controller('EditTaskCtrl', ['$scope', '$location', 'Tasks', '$routeParams', ($scope, $location, Tasks, $routeParams) ->
  task_id = $routeParams.id
  $scope.taskQuery = Tasks.one(task_id)

  $scope.taskQuery.get().then( (result) ->
    $scope.task = {
      id: result.id
      description: result.description
      due_date: result.due_date
      priority: result.priority.toString()
    }
  )

  $scope.title = 'Edit task'
  $scope.commit = 'Save'

  $scope.commitTask = ->
    $scope.taskQuery.put($scope.task).then(() ->
      $location.path('/')
    )

  $scope.cancel = ->
    $location.path('/')
])