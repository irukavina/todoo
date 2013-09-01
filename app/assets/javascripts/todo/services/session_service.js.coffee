"use strict"
angular.module("todoApp.services").service "sessionService", ["userSessionService", 'userRegistrationService', '$cookieStore', 'authService', 'Restangular', (userSessionService, userRegistrationService, $cookieStore, authService, Restangular) ->
  config =
    userSession: new userSessionService()
    userRegistration: new userRegistrationService()
    signIn: (data) ->
      $cookieStore.put('_current_user', data)
      config.refreshAuthTokenHeaders()
      authService.loginConfirmed()
    signOut: () ->
      $cookieStore.remove('_current_user')
    currentUser: () ->
      $cookieStore.get('_current_user')
    authToken: () ->
      currentUser = $cookieStore.get('_current_user')
      return currentUser['auth_token'] if currentUser && currentUser['auth_token']
      null
    refreshAuthTokenHeaders: () ->
      Restangular.setDefaultHeaders({'Authorization': 'Token token="' + config.authToken() + '"'})

]

