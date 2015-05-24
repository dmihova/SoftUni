app.controller('PostController',
    function ($scope, $location,$routeParams,usSpinnerService,
              postService,profileService, userService, notifyService,
              PAGE_SIZE  ) {


        $scope.addPost = function(){
            if(userService.isLogged()) {
                 $scope.post.username = $routeParams['name'];
                 postService(userService.getAccessToken()).addPost($scope.post).$promise.then(
                    function(data){
                        $scope.post.newPostText = "";
                        notifyService.showInfo("Post published.");
                     },
                    function(error){
                         notifyService.showError("Add post failed!", error);
                    }
                );
            }
        };

        $scope.deletePost = function(post){
            if(userService.isLogged()) {
                postService(userService.getAccessToken()).removePost(post.id).$promise.then(
                    function(){
                        var index =  $scope.posts.indexOf(post);
                        $scope.posts.splice(index, 1);
                        notifyService.showInfo("Post deleted.");
                    },
                    function(error){
                        notifyService.showError("Delete post failed.", error);
                    }
                );
            }
        };

        $scope.editPost = function(post){
            if(userService.isLogged()) {
                usSpinnerService.spin('spinner-1');
                postService(userService.getAccessToken()).editPost(post.id, post.newText).$promise.then(
                    function(){
                        post.postContent = post.newPostContent;
                        usSpinnerService.stop('spinner-1');
                        notifyService.showInfo("Post successfully edited.");
                    },
                    function(error){
                        notifyService.showError("Failed to edit post!", error);
                        usSpinnerService.stop('spinner-1');
                    }
                );
            }
        };

    })
;