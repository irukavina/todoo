angular.module('todoApp.directives').directive('authenticationRequired', ->
  {
    restrict: 'A',
    link: (scope, elem, attrs) ->
      login_wrapper = elem.find('#login-wrapper')
      content_wrapper = elem.find('#content-wrapper')

      login_wrapper.hide()

      scope.$on "event:auth-loginRequired", ->
        login_wrapper.slideDown "slow", ->
          content_wrapper.hide()

      scope.$on "event:auth-loginConfirmed", ->
        content_wrapper.show()
        login_wrapper.slideUp()
  }
)