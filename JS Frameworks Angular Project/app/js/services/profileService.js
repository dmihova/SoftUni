app.factory('profileService', function($http, $q, $resource, BASE_URL){
    return function(token){
        $http.defaults.headers.common['Authorization'] = 'Bearer ' + token;

        var profile = {},
            resource = $resource(
                BASE_URL + 'me/:option1/:option2',
                { option1: '@option1', option2: '@option2' },
                {
                    edit: {
                        method: 'PUT'
                    }
                }
            );

       // current user profile get and update
        profile.currentUser = function(){
            return resource.get();
        };
        profile.update = function(data, option1){
            return resource.edit({option1: option1}, data);
        };


        // Feed  - posts are in another service
        profile.getNewsFeed = function(pageSize, startPostId){
            var option1 = 'feed?StartPostId' + (startPostId ? "=" + startPostId : "") + "&PageSize=" + pageSize;
            return resource.query({ option1: option1});
        };



        return profile;
    }
});

