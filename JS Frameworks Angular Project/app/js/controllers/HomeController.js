// The HomeController holds the presentation logic for the home screen

app.controller('HomeController', function ($scope,$location,$routeParams,authenticationService) {

    // $scope.userName = authenticationService.getUsername();
    // $scope.defaultProfileImage = DEFAULT_PROFILE_IMAGE;
    //  $scope.showPendingRequest = false;
    //  $scope.isOwnWall = authentication.getUsername() === $routeParams['username'];
    // $scope.isOwnFeed = $location.path() === '/';

    function getReceivedRequests() {
        //if ( isLogged()){
        //    profileService(authenticationService.getAccessToken()).getPendingRequests().$promise.then(
        //       function(data){
        //           $scope.pendingRequests = data;
        //       }
        //   );
        //  }
    }

});

