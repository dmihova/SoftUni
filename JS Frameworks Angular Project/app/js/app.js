var app = angular.module('socialNetwork', [ 'ngRoute','ngResource','angularSpinner']);


app.constant({
    'BASE_URL':'http://softuni-social-network.azurewebsites.net/api/',
    'PAGE_SIZE': 5
  });


app.config(function($routeProvider  ) {

    $routeProvider

        .when('/profile/password/',{
            templateUrl: 'templates/edit-password.html',
            controller: 'ProfileController'
        } )
        .when('/profile/edit', {
            templateUrl: 'templates/edit-profile.html',
            controller: 'ProfileController'
        })
        .when('/news', {
            templateUrl: 'templates/news-feed.html',
            controller: 'ProfileController'
        })
        .when('/requests', {
            templateUrl: 'templates/friend-request.html',
            controller: 'ProfileController'
        })


        .when('/',
        {
            templateUrl:'templates/home.html',
            controller:'MainController'
        })
        .otherwise({redirectTo:'/'})


});


app.controller('AppController', function ($scope, authenticationService) {
        // Put the authService in the $scope to make it accessible from all screens
        $scope.authService = authenticationService;
        $scope.isLogged = function(){
            return authenticationService.isLogged();
        };
    }
);

