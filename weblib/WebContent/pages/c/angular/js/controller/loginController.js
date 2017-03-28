angular.module("LoginModule",["ngCookies","httpRequest"])
    .controller("LoginController" ,["$scope","$cookies","global.staticInfo","httpRequest.sendRequest","$state",
        function ($scope,$cookies,staticInfo,sendRequest,$state) {


        $scope.saveToCookies=function(){
            $cookies.username=$scope.loginInfo.username;
            $cookies.password=$scope.loginInfo.password;
            $scope.loginInfo.shouldRemember=true;
        };

        $scope.getFromCookies=function(){
            $scope.loginInfo.username=$cookies.username;
            $scope.loginInfo.password=$cookies.password;
            $scope.loginInfo.shouldRemember=true;
        };

        $scope.cleanCookies=function(){
            $cookies.username=$cookies.password=undefined;
            $scope.loginInfo.shouldRemember=false;
        };

        $scope.$watch("loginInfo.shouldRemember", function (newVal, oldVal) {
            if (!newVal) {
                $scope.cleanCookies();
            }
        });


        $scope.login=function(username,password){
            if($scope.loginInfo.shouldRemember) {
                $scope.saveToCookies();

            }

            var paramsStr="account="+$scope.loginInfo.username+"&password="+$scope.loginInfo.password;
            var paramsObj={"account":$scope.loginInfo.username,"password":$scope.loginInfo.password};
            sendRequest("/login/authenticate.action",paramsObj,
                function(data, status, headers, config){
                    var paramsStr="memberId="+data.members[0].id;
                    sendRequest("/login/selectMember.action",paramsStr,
                        function(data, status, headers, config){
//                            var paramsStr="memberId="+data.members[0].id;
//                            sendRequest("/user/lo.action",paramsStr,
//                                function(data, status, headers, config){
                                    $state.go("main");

//                                });

                        });
                });
        };

        $scope.loginInfo={};
        $scope.loginInfo.username="";
        $scope.loginInfo.password="";
        $scope.loginInfo.shouldRemember=false;

        if($cookies.username!=undefined){
            $scope.getFromCookies();
        }
    }]);