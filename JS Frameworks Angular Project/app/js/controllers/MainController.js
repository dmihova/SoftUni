// The HomeController holds the presentation logic for the home screen and login/register

app.controller('MainController', function ($scope,$location,$routeParams,usSpinnerService,authenticationService,profileService,notifyService) {


    function getReceivedRequests() {
        if (authenticationService.isLogged()){
            profileService(authenticationService.getAccessToken()).getPendingRequests().$promise.then(
                function(data){
                    $scope.pendingRequests = data;
                }
            );
        }
    }

    $scope.isLogged = function(){
        return authenticationService.isLogged();
    };
    $scope.register = function(userData) {
        authenticationService.register(userData,
            function success() {
                notifyService.showInfo("User registered successfully");
                $location.path("#/");
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
                $location.path("#/");
            },
            function error(err) {
                notifyService.showError("Login failed", err);
            })
    };

    $scope.logout = function(){
        authenticationService.logout(
            function success() {
                notifyService.showInfo('Goodbye!' );
                $location.path('#/');
            }, function error(err) {
                notifyService.showError("Logout failed", err);
            })
    };


});

