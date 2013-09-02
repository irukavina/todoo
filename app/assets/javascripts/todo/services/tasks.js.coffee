angular.module('todoApp.services').factory('Tasks', ['Restangular', 'SessionService', (Restangular, SessionService) ->
  {
    all: () ->
      SessionService.refreshAuthTokenHeaders()
      Restangular.all('api/tasks')
    one: (id) ->
      SessionService.refreshAuthTokenHeaders()
      Restangular.one('api/tasks', id)

  }
])