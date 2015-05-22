// The AuthorizationController is responsible for the "Login" and "Register" screen
'use strict';

app.controller('AuthenticationController',
    function ($scope, $location, authenticationService, notifyService) {

        $scope.register = function(userData) {
            authenticationService.register(userData,
                function success() {
                    notifyService.showInfo("User registered successfully");
                    $location.path("/");
                },
                function error(err) {
                    notifyService.showError("User registration failed", err);
                }
            );
        };


        $scope.login = function(userData) {
            authenticationService.login(userData,
                function success() {
                    notifyService.showInfo("Login successful");
                    $location.path("/");
                },
                function error(err) {
                    notifyService.showError("Login failed", err);
                })
        };
});











