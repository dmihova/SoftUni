app.controller('FriendController',
    function ($scope, $location, usSpinnerService, $routeParams,
              friendService,profileService, userService, notifyService,
              PAGE_SIZE) {

        $scope.searchUserByCriteria = function () {
            if (userService.isLogged() && $scope.searchCriteria.trim() !== "") {
                userService.searchUserByCriteria($scope.searchCriteria,
                    function success(data) {
                        $scope.searchUserResults = data;
                    },
                    function error(err) {
                    }
                );
            } else {
                $scope.searchUserResults = undefined;
            }
        };
        $scope.clearSearchUsers = function () {
            $scope.searchUserResults = undefined;

        };
        $scope.searchCriteria = "";

        $scope.sendRequest = function (otherUserData) {
            if (userService.isLogged()) {
                usSpinnerService.spin('spinner-1');
                friendService(userService.getAccessToken()).sendFriendRequest(otherUserData.username).$promise.then(
                    function () {
                        notifyService.showInfo("Request sent");
                        otherUserData.status = 'sent';
                        usSpinnerService.stop('spinner-1');
                    },
                    function (error) {
                        notifyService.showError("Request failed!", error);
                        usSpinnerService.stop('spinner-1');
                    }
                );
            }
        };

        $scope.getPendingRequests = function () {
            if (userService.isLogged()) {
                friendService(userService.getAccessToken()).getPendingRequests().$promise.then(
                    function (data) {
                        $scope.requests = data;
                    }, function (error) {
                        notifyService.showError("Requests load failed", error);
                    }
                );
            }
        };


        $scope.acceptRequest = function (request) {
            if (userService.isLogged()) {
                friendService(userService.getAccessToken()).acceptRequest(request.id).$promise.then(
                    function () {
                        $scope.getPendingRequests();
                        $scope.requests.splice(index, 1);
                        notifyService.showInfo("Request accepted.");
                    },
                    function (error) {
                        notifyService.showError("Request failed", error);
                    }
                );
            }
        };

        $scope.rejectRequest = function (request) {
            if (userService.isLogged()) {
                friendService(userService.getAccessToken()).rejectRequest(request.id).$promise.then(
                    function () {
                        var index = $scope.requests.indexOf(request);
                        $scope.requests.splice(index, 1);
                        notifyService.showInfo("Request rejected.");
                    }, function (error) {
                        notifyService.showError("Request failed!", error);
                    }
                );
            }
        };


        $scope.getCurrentUserFiendsList = function () {
            if (userService.isLogged()) {
                usSpinnerService.spin('spinner-1');
                friendService(userService.getAccessToken()).getFriendsList().$promise.then(
                    function (data) {
                        $scope.friendsData = data;
                        usSpinnerService.stop('spinner-1');
                        notifyService.showInfo("Friends loaded");
                    },
                    function (error) {
                        usSpinnerService.stop('spinner-1');
                        notifyService.showError("Failed to load friends", error);
                    }
                );
            }
        };



        $scope.getFriendsByParam = function () {
            if (userService.isLogged()) {
                if ($routeParams.name === userService.getCurrentUserName()) {
                    $scope.getCurrentUserFiendsList()
                }
                else {
                    usSpinnerService.spin('spinner-1');
                    friendService(userService.getAccessToken()).getOtherFriendsList($routeParams.name).$promise.then(
                        function (data) {
                            data.dsplName = $routeParams.name;
                            $scope.friendsData = data;
                            usSpinnerService.stop('spinner-1');
                            notifyService.showInfo("Friends loaded");
                        },
                        function (error) {
                            usSpinnerService.stop('spinner-1');
                            notifyService.showError("Failed to load friends", error);
                        }
                    );
                }
            }
        };

        $scope.getCurrentUserFriendsListPreview = function () {
            if (userService.isLogged()) {
                friendService(userService.getAccessToken()).getFriendsListPreview().$promise.then(
                    function (data) {
                        var  name  =userService.getCurrentUserName();
                        var num= 3,total =data.totalCount;
                        if  (total >num){
                            data.friends.length = num;
                        }
                        data.friendsUrl = '#/users/' +name + '/friends/';
                        $scope.friendsPreviewData = data;
                        usSpinnerService.stop('spinner-1');
                    },
                    function (error) {
                        notifyService.showError("Failed to load friends", error);
                    }
                );
            }
        };
        $scope.getOtherUserFriendsListPreview = function () {
             if  (userService.isLogged()) {
                 if ($routeParams.name === userService.getCurrentUserName()) {
                     $scope.getCurrentUserFiendsList()
                 }
                 else {
                     friendService(userService.getAccessToken()).getOtherFriendsListPreview($routeParams.name).$promise.then(
                         function (data) {
                             var name = userService.getCurrentUserName();
                             var num = 3, total = data.totalCount;
                             if (total > num) {
                                 data.friends.length = num;
                             }
                             data.friendsUrl = '#/users/' + $routeParams.name + '/friends/';
                             $scope.friendsPreviewData = data;
                             usSpinnerService.stop('spinner-1');
                         },
                         function (error) {
                             notifyService.showError("Failed to load friends", error);
                         }
                     );
                 }
             }

        };
        $scope.getOtherUser = function () {
            if (userService.isLogged()) {
                usSpinnerService.spin('spinner-1');
                userService.getFullUserData($routeParams.name,
                    function success(data) {
                        $scope.otherUser = data;
                        if (data.isFriend) {
                            $scope.otherUser.status = 'friend';
                        } else if (data.hasPendingRequest) {
                            $scope.otherUser.status = 'sent';
                        } else {
                            $scope.otherUser.status = 'invite';
                        }
                        usSpinnerService.stop('spinner-1');
                    },
                    function error(err) {
                        usSpinnerService.stop('spinner-1');
                        notifyService.showError("User load failed!", error);
                    }
                );
            }
        };


    });

