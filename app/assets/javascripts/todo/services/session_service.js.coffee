"use strict"
angular.module("todoApp.services").service "SessionService", ["UserSessionService", 'UserRegistrationService', '$cookieStore', 'authService', 'Restangular', (userSessionService, userRegistrationService, $cookieStore, authService, Restangular) ->
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
    isSignedIn: () ->
      !!config.currentUser()
    email: () ->
      (config.currentUser() || {})['email']
    authToken: () ->
      (config.currentUser() || {})['auth_token']
    refreshAuthTokenHeaders: () ->
      Restangular.setDefaultHeaders({'Authorization': 'Token token="' + config.authToken() + '"'})

]

