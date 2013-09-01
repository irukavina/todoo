angular.module('todoApp.controllers').controller('MainCtrl', ['$scope', 'Tasks', ($scope, Tasks) ->
  $scope.tasks = Tasks.getList()
])