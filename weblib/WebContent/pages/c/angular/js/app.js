/**
 * Created by dcampus2011 on 15/8/21.
 */
//var toastr = require("toastr");
angular
    .module('WebLibApp', [
        'ui.router',
        'global',
        'LoginModule',
        'MainModule',
        'keepAlive',
        'ui.tree',
        'sidebarController',
        'PersonalController',
        'TopToolController',
        'shareToMeController',
        'myshareController',
        'shareController',
        'fileChainController',
        'moveCopyController',
        'emailController',
        'renameController',
        'createLinkController',
        'modifyAccountController',
        'newFolderController',
        'ngProgress'
    ])
    .run(["$rootScope", "$state", "$stateParams","ngProgressFactory", function ($rootScope, $state, $stateParams,ngProgressFactory) {
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
        $rootScope.path = "";
        $rootScope.listOptions = {
            parentId: 0
        };
        $rootScope.toastr = require("toastr");
        $rootScope.toastr.options = {
            "closeButton": false,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "1500",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };
        $rootScope.status = {};
        $rootScope.progressbar = ngProgressFactory.createInstance();
        $rootScope.progressbar.setColor("dodgerblue")
    }])
    .config(function ($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.otherwise("/login");
        $stateProvider.state("login", {
            url: "/login",
            views: {
                "wrap": {
                    templateUrl: "tpl/login.html",
                    controller: "LoginController"
                }
            }
        }).state("main", {
            url: "/main",
            views: {
                "wrap": {
                    templateUrl: "tpl/main.html",
                    controller: "MainController"
                },
                "content@main": {
                    templateUrl: "tpl/personal.html",
                    controller: "PersonalController"
                },
                "slider@main": {
                    templateUrl: "tpl/sidebar.html",
                    controller: "sidebarController"
                },
                "btnWrap@main": {
                    templateUrl: "tpl/topToolBar.html",
                    controller: "TopToolController"
                }
            }
        }).state("main.public", {
            url: "/public:id",
            views: {
                "content@main": {
                    templateUrl: "tpl/personal.html",
                    controller: "PersonalController"
                }
            }
        }).state("main.shareToMe", {
            url: "/shareToMe",
            views: {
                "content@main": {
                    templateUrl: "tpl/personal.html",
                    controller: "shareToMeController"
                }
            }
        }).state("main.myshare", {
            url: "/myshare",
            views: {
                "content@main": {
                    templateUrl: "tpl/personal.html",
                    controller: "myshareController"
                }
            }
        });
    }
).controller("appController", ["$scope", "$rootScope", "$state", "httpRequest.sendRequest", function ($scope, $rootScope, $state, sendRequest) {
        /**获取登录状态及个人信息**/
        sendRequest("/user/status.action", {}, function (data) {
            if (data.status == "login") {
                $rootScope.status = data;
            } else {
                $state.go("login");//如果没登陆则跳转到登录页
            }
        });
        $rootScope.logout = function () {
            sendRequest("/login/logout.action", {}, function (data) {
            });
        }
    }]);

