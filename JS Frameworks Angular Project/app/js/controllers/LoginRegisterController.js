// The AuthorizationController is responsible for the "Login" and "Register" screen
'use strict';

app.controller('LoginRegisterController',
    function ($scope, $location, authenticationService, notifyService) {

        $scope.register = function(userData) {
            authenticationService.register(userData,
                function success() {
                    notifyService.showInfo("User registered successfully");
                    $location.path("/home");
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
                    $location.path("/home");
                },
                function error(err) {
                    notifyService.showError("Login failed", err);
                })
        };
});











