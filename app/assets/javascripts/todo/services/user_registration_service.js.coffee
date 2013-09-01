"use strict"
angular.module("todoApp.services").factory "userRegistrationService", ["$http", ($http) ->
  instance = (options) ->
    angular.extend(@, options)

  instance::$save = ->
    $http.post 'http://localhost:3000/api/registrations',
      email: @email
      password: @password
      password_confirmation: @password_confirmation

  instance
]
