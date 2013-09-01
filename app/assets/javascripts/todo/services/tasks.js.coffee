angular.module('todoApp.services').factory('Tasks', ['Restangular', 'sessionService', (Restangular, sessionService) ->
  {
    all: () ->
      sessionService.refreshAuthTokenHeaders()
      Restangular.all('api/tasks')
    one: (id) ->
      sessionService.refreshAuthTokenHeaders()
      Restangular.one('api/tasks', id)

  }
])