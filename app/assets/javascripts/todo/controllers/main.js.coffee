angular.module('todoApp.controllers').controller('MainCtrl', ['$scope', '$location', 'Tasks', ($scope, $location, Tasks) ->
  $scope.newTask = { description: '' }
  $scope.reloadTasks = ->
    Tasks.all().getList().then((results) ->
      $scope.tasks = results
    )

  $scope.reloadTasks()

  $scope.updateTask = (task) ->
    task.put()
  $scope.createTask = () ->
    $location.path('/tasks/new')

  $scope.editTask = (task) ->
    $location.path("/tasks/#{task.id}/edit")

  $scope.deleteTask = (task) ->
    task.remove().then( ->
      $scope.reloadTasks()
    )


])