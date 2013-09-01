"use strict"
angular.module("todoApp.services").factory "userSessionService", ["$http", ($http) ->
  instance = (options) ->
    angular.extend(@, options)

  instance::$save = ->
    $http.post 'http://localhost:3000/api/sessions',
      email: @email
      password: @password

  instance::$destroy = ->
    $http.delete 'http://localhost:3000/api/sessions'

  instance
]