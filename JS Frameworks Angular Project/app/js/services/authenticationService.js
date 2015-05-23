'use strict';

app.factory('authenticationService',
    function ($http, BASE_URL) {
        return {
            login: function(userData, success, error) {
                var request = {
                    method: 'POST',
                    url: BASE_URL + 'users/login',
                    data: userData
                };
                $http(request).success(function(data) {
                    sessionStorage['currentUser'] = JSON.stringify(data);
                    success(data);
                }).error(error);
            },

            register: function(userData, success, error) {
                var request = {
                    method: 'POST',
                    url: BASE_URL + 'users/register',
                    data: userData
                };
                $http(request).success(function(data) {
                    sessionStorage['currentUser'] = JSON.stringify(data);
                    success(data);
                }).error(error);
            },

            logout: function() {
                delete sessionStorage['currentUser'];
            },

            getCurrentUser : function() {
                var userObject = sessionStorage['currentUser'];
                if (userObject) {
                    return JSON.parse(sessionStorage['currentUser']);
                }
            },

             isLogged : function() {
                return sessionStorage['currentUser'] != undefined;
            },

            getAuthHeaders : function() {
                var headers = {};
                var currentUser = this.getCurrentUser();
                if (currentUser) {
                    headers['Authorization'] = 'Bearer ' + currentUser.access_token;
                }
                return headers;
            },

            getUserProfile: function(success, error) {
                var request = {
                    method: 'GET',
                    url: BASE_URL + 'users/profile',
                    headers: this.getAuthHeaders()
                };
                $http(request).success(success).error(error);
            },

            editUser: function(userData, success, error) {
                var request = {
                    method: 'PUT',
                    url: BASE_URL + 'users/profile',
                    data: userData,
                    headers: this.getAuthHeaders()
                };
                $http(request).success(success).error(error);
            },

            changePass: function(passData, success, error) {
                var request = {
                    method: 'PUT',
                    url: BASE_URL + 'users/changePassword',
                    data: passData,
                    headers: this.getAuthHeaders()
                };
                $http(request).success(success).error(error);
            }
        }
    }
);

