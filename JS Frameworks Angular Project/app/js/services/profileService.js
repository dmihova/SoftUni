app.factory('profileService', function($http, $q, $resource, BASE_URL){
    return function(token){
        $http.defaults.headers.common['Authorization'] = 'Bearer ' + token;

        var profile = {};
        var    resource = $resource(
                BASE_URL + 'me/:option1/:option2',
                { option1: '@option1', option2: '@option2' },
                {
                    edit: {
                        method: 'PUT'
                    }
                }
            );
        var    resourceOther = $resource(
            BASE_URL + 'users/:option1/:option2/:option3',
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


        profile.getFeed = function(pageSize, startPostId){
            var option1 = 'feed?' + "PageSize=" + pageSize;
           /// StartPostId + (startPostId ? "=" + startPostId : "")
            return resource.query({ option1: option1});
        };

        profile.getFeedOtherUser =function(Username){
            return resourceOther.query({ option1: Username,option2: "wall",option3:"?PageSize=10"});
        }

        return profile;
    }
});

