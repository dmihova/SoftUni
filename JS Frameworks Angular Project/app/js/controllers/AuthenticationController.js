// The AuthorizationController is responsible for the "Login" and "Register" screen
app.controller('AuthenticationController', function ($scope, $location, authorizationService, notifyService) {

    $scope.register = function () {

        authorizationService.register($scope.user)
            .then(function(data){
                authorizationService.setCredentials(data);
                console.log(data)
            }, function(err){
                console.log(err);
            });
        $location.path('/home');
    };

    $scope.login = function () {

        authorizationService.login($scope.user)
            .then(function(data){
                authorizationService.setCredentials(data);
                console.log(data)
            }, function(err){
                console.log(err);
            });
        $location.path('/home');

    };
} );