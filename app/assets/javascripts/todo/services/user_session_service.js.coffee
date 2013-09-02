"use strict"
angular.module("todoApp.services").factory "UserSessionService", ["$http", ($http) ->
  instance = (options) ->
    angular.extend(@, options)

  instance::clearFields = ->
    @email = ''
    @password = ''

  instance::$save = ->
    $http.post '/api/sessions',
      email: @email
      password: @password

  instance::$destroy = ->
    $http.delete '/api/sessions'

  instance
]