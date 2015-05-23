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
        profile.me = function(){
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

        //Friends request
        profile.getPendingRequests = function(){
            return resource.query({ option1: 'requests' });
        };
        profile.acceptRequest = function(requestId){
            var option2 = '' + requestId + '?status=approved';
            return resource.edit({ option1: 'requests', option2: option2});
        };
        profile.rejectRequest = function(requestId){
            var option2 = '' + requestId + '?status=rejected';
            return resource.edit({ option1: 'requests', option2: option2});
        };


        // send request
        profile.sendFriendRequest = function(username){
            return resource.save({ option1: 'requests', option2: username});
        };


        //Friends list
        profile.getFriendsList = function(){
            return resource.query({ option1: 'friends'});
        };

        profile.getFriendsListPreview = function(){
            return resource.get({ option1: 'friends', option2: 'preview'});
        };





        return profile;
    }
});