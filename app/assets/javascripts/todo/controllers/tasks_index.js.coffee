angular.module('todoApp.controllers').controller('TasksIndexCtrl', ['$scope', '$location', 'Tasks', '$dialog', ($scope, $location, Tasks, $dialog) ->
  $scope.newTask = { description: '' }

  $scope.order = 'completed'
  $scope.reversed = false
  $scope.setOrder = (order) ->
    if order == $scope.order
      $scope.reversed =  !$scope.reversed
    else
      $scope.reversed = false
    $scope.order = order


  $scope.reloadTasks = ->
    Tasks.all().getList().then (results) ->
      $scope.tasks = results

  $scope.reloadTasks()

  $scope.updateTask = (task) ->
    task.put()

  $scope.createTask = () ->
    $location.path('/tasks/new')

  $scope.editTask = (task) ->
    $location.path("/tasks/#{task.id}/edit")

  $scope.deleteTask = (task) ->
    if confirm("Are you sure you want to delete '#{task.description}' task?")
      task.remove().then( ->
        $scope.reloadTasks()
      )

  $scope.archiveCompletedTasks = ->
    Tasks.archiveCompleted().then ->
      $scope.reloadTasks()
])