app.controller('ProfileController',
            function ($scope, $location,usSpinnerService,
                            profileService, authenticationService, notifyService,
                            PAGE_SIZE  ) {



    $scope.editPassword = function(){
        if(authenticationService.isLogged()) {
            usSpinnerService.spin('spinner-1');
            profileService(authenticationService.getAccessToken()).update($scope.passwordUpdate, 'changepassword').$promise.then(
                function () {
                    usSpinnerService.stop('spinner-1');
                    notifyService.showInfo('Password successfully changed.');
                    $location.path('/home');
                },
                function (error) {
                    usSpinnerService.stop('spinner-1');
                    notifyService.showError('Password change failed!', error);
                }
            );
        }
    };


    $scope.clickUpload = function(){
        angular.element('#profile-image').trigger('click');
    };



});