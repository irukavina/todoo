angular.module('todoApp.templates', [])
angular.module('todoApp.filters', [])
angular.module('todoApp.directives', ['http-auth-interceptor'])
angular.module('todoApp.services', ['ngCookies', 'restangular'])
angular.module('todoApp.controllers', [])
angular.module('todoApp', ['todoApp.templates', 'todoApp.directives', 'todoApp.services', 'todoApp.controllers', 'todoApp.filters', 'ui.bootstrap']).config(['$routeProvider', 'templateUrls', ($routeProvider, templateUrls) ->
  $routeProvider.when('/', {
    templateUrl: templateUrls['main'],
    controller: 'MainCtrl'
  }).when('/tasks/new', {
    templateUrl: templateUrls['tasks/form'],
    controller: 'NewTaskCtrl'
  }).when('/tasks/:id/edit', {
    templateUrl: templateUrls['tasks/form'],
    controller: 'EditTaskCtrl'
  })
])
