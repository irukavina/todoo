angular.module('todoApp.directives').directive('application', ['templateUrls', (templateUrls) ->
  restrict: 'A'
  templateUrl: templateUrls['main']
])