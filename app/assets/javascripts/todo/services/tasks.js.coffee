angular.module('todoApp.services').factory('Tasks', ['Restangular', 'sessionService', (Restangular, sessionService) ->
  sessionService.refreshAuthTokenHeaders()

  Restangular.all('api/tasks')
#  $resource('/api/tasks/:id', { id: '@id' }, {
#
#  })
])