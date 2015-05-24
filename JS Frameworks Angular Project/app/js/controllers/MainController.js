// The HomeController holds the the home screen and login/register

app.controller('MainController', function ($scope, $location, $routeParams, usSpinnerService, userService, profileService, notifyService) {


    function getReceivedRequests() {
        if (userService.isLogged()) {
            profileService(userService.getAccessToken()).getPendingRequests().$promise.then(
                function (data) {
                    $scope.pendingRequests = data;
                }
            );
        }
    }

    $scope.isLogged = function () {
        return userService.isLogged();
    };
    $scope.register = function (userData) {
        userService.register(userData,
            function success() {
                notifyService.showInfo("User registered successfully");
                $location.path("#/");
            },
            function error(err) {
                notifyService.showError("User registration failed", err);
            }
        );
    };
    $scope.login = function (userData) {
        userService.login(userData,
            function success() {
                notifyService.showInfo("Login successful");
                $location.path("#/");
            },
            function error(err) {
                notifyService.showError("Login failed", err);
            })
    };

    $scope.logout = function () {
        userService.logout(
            function success() {
                notifyService.showInfo('Goodbye!');
                $location.path('#/');
            }, function error(err) {
                notifyService.showError("Logout failed", err);
            })
    };

});

