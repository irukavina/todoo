angular.module('todoApp.templates', [])
angular.module('todoApp.directives', ['http-auth-interceptor'])
angular.module('todoApp.services', ['ngCookies', 'restangular'])
angular.module('todoApp.controllers', [])
angular.module('todoApp', ['todoApp.templates', 'todoApp.directives', 'todoApp.services', 'todoApp.controllers']).config(['$routeProvider', 'templateUrls', ($routeProvider, templateUrls) ->
  $routeProvider.when('/', {
    templateUrl: templateUrls['main'],
    controller: 'MainCtrl'
  })
])
