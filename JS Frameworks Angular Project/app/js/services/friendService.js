app.factory('friendService', function($http, $q, $resource, BASE_URL,PAGE_SIZE){
    return function(token){
        $http.defaults.headers.common['Authorization'] = 'Bearer ' + token;

        var friend = {},
            resource = $resource(
                BASE_URL + 'me/:option1/:option2',
                { option1: '@option1', option2: '@option2' },
                {
                    edit: {
                        method: 'PUT'
                    }
                }
            ),
            resourceOther= $resource(
                BASE_URL + 'users/:option1/:option2/:option3',
            {
                option1: '@option1',
                option2: '@option2',
                option3: '@option3'
                },
            {
                edit: {
                    method: 'PUT'
                    }
                }
        );

        //Friends request
        friend.getPendingRequests = function(){
            return resource.query({ option1: 'requests' });
        };
        friend.acceptRequest = function(requestId){
            var option2 = '' + requestId + '?status=approved';
            return resource.edit({ option1: 'requests', option2: option2});
        };
        friend.rejectRequest = function(requestId){
            var option2 = '' + requestId + '?status=rejected';
            return resource.edit({ option1: 'requests', option2: option2});
        };


        // send request
        friend.sendFriendRequest = function(username){
            return resource.save({ option1: 'requests', option2: username});
        };


        //Friends list
        friend.getFriendsList = function(){
            return resource.query({ option1: 'friends'});
        };

        friend.getFriendsListPreview = function(){
            return resource.get({ option1: 'friends', option2: 'preview'});
        };
        //Other friends list
        friend.getOtherFriendsList = function(username){
            return resourceOther.query({option1: username, option2: 'friends'});
        };
        //Other friends list preview
        friend.getOtherFriendsListPreview = function(username){
            return resourceOther.get({option1: username, option2: 'friends', option3: 'preview'});
        };

        return friend;
    }
});
