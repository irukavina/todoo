angular.module('todoApp.filters').filter('priority', ->
  (priority) ->
    {
      '2': 'Very low'
      '1': 'Low'
      '0': 'Normal'
      '-1': 'High'
      '-2': 'Very high'
    }[priority.toString()]
)