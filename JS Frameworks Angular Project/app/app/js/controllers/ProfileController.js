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

    $scope.getProfileDetails = function(){
        if(authenticationService.isLogged()) {
             usSpinnerService.spin('spinner-1');
             profileService(authenticationService.getAccessToken()).currentUser().$promise.then(
                function (data) {
                   $scope.currentUser = data;
                   usSpinnerService.stop('spinner-1');
                },
                function (error) {
                   usSpinnerService.stop('spinner-1');
                   notifyService.showError("Profile details are not available!", error)
                } );
        }
    };

    $scope.editProfileDetails = function(){
        usSpinnerService.spin('spinner-1');
            if(authenticationService.isLogged()) {
                profileService(authenticationService.getAccessToken()).update($scope.currentUser).$promise.then(
                   function () {
                      usSpinnerService.stop('spinner-1');
                      notifyService.showInfo('Profile successfully changed.');
                       $location.path('/home');
                   },
                   function (error) {
                       usSpinnerService.stop('spinner-1');
                       notifyService.showError('Profile update failed!', error);
                   }
            );
        }
    };


    $scope.profileImageSelected = function(fileInputField) {
        delete $scope.currentUser.profileImageData;
        var file = fileInputField.files[0];
        if  (file.type.match('image/jpeg')) {
            var reader = new FileReader();
            reader.onload = function() {
                    $scope.currentUser.profileImageData = reader.result;
                    $(".profile-image-box").html("<img src='" + reader.result + "'>");
                    };
            reader.readAsDataURL(file);
            }
        else {
            $(".profile-image-box").html("<p>File type not supported!</p>"); }
        };

         $scope.coverImageSelected = function(fileInputField) {
             delete $scope.currentUser.coverImageData;
             var file = fileInputField.files[0];
              if  (file.type.match(/image\/.*/)) {
                    var reader = new FileReader();
                    reader.onload = function() {
                    $scope.currentUser.coverImageData = reader.result;
                            $(".cover-image-box").html("<img src='" + reader.result + "'>");
                    };
                        reader.readAsDataURL(file);
                    }
                    else {
                        $(".cover-image-box").html("<p>File type not supported!</p>"); }
                };


});