// The AuthorizationController is responsible for the "Login" and "Register" screen
app.controller('AuthenticationController', function ($scope, $location, authorizationService, notifyService) {

    $scope.register = function () {

        authorizationService.register($scope.registerData)
            .then(function(data){
                authorizationService.setCredentials(data);
                console.log(data)
            }, function(err){
                console.log(err);
            });
        $location.path('/home');
    };

    $scope.login = function () {

        authorizationService.login($scope.loginData)
            .then(function(data){
                authorizationService.setCredentials(data);
                console.log(data)
            }, function(err){
                console.log(err);
            });
        $location.path('/home');

    };
} );