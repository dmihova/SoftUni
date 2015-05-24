app.factory('postService', function($http, $q, $resource, BASE_URL){
    return function(token){
        $http.defaults.headers.common['Authorization'] = 'Bearer ' + token;

        var post = {};
        var  resource = $resource(
                BASE_URL + 'posts/:option1',
                { option1: '@option1'},
                {
                    edit: {
                        method: 'PUT'
                    }
                }
            );

        post.addPost = function(postData){
            var postPut = {
                         'postContent': postData.newPostText,
                         'username': postData.username
                        };
            return resource.save(postPut);
        };
        post.removePost = function(postId){
            return resource.remove({option1: postId});
        };
        post.editPost = function(postId, post){
            var post = { 'postContent': postContent};
            return resource.edit({option1: postId}, postData);
        };

        return post;
    }
});
