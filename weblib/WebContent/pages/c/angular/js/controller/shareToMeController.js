var shareToMeController = angular.module("shareToMeController", ["ngGrid"]);
shareToMeController.controller("shareToMeController", ["$scope", "$http", "$rootScope", "$state", "httpRequest.sendRequest", "modalWindow", "modalConfirm",
    function ($scope, $http, $rootScope, $state, sendRequest, modalWindow, modalConfirm) {
        $scope.id = 0;
        $rootScope.floor = 0;
        $scope.isHidden = true;
        $rootScope.AddDir=false;
        $rootScope.Delete=true;
        $rootScope.Upload=false;
        $rootScope.isBack=true;
        $scope.event = true;
        $rootScope.mySelections = [];
        $scope.totalServerItems = 0;
        $scope.breadcrumbpath = [{id: -$rootScope.status.personGroupId, displayName: "我的接收"}];
        /**分页**/
        $scope.pagingOptions = {
            pageSize: 40,
            currentPage: 1,
            start: 0,
            totalPage: 0
        };
        //grid初始化设置
        $scope.gridOptions = {
            data: "data",
            multiSelect: true,
            showSelectionCheckbox: true,
            selectWithCheckboxOnly: true,
            rowHeight: 30,
            headerRowHeight: 25,
            enableSorting: false,
            selectedItems: $rootScope.mySelections,
            enablePaging: true,
            showFooter: false,
            totalServerItems: 'totalServerItems',
            pagingOptions: $scope.pagingOptions,
            init: function () {
                angular.element(document.querySelector(".ngViewport")).height(angular.element(window).height() - 102);
                angular.element(window).resize(function () {
                    angular.element(document.querySelector(".ngViewport")).height(angular.element(window).height() - 102);
                });

            },
            rowTemplate: '<div ng-mouseover="rowOver()" ng-mouseleave="rowLeave()"  ng-repeat="col in renderedColumns" ng-class="col.colIndex()" class="ngCell {{col.cellClass}}" ng-cell></div>',
            columnDefs: [
                {
                    field: "displayName", displayName: '名称',
                    cellTemplate: 'tpl/listTpls/shareToMeCell.html'
                },
                {
                    field: "size", width: 80, displayName: '文件大小',
                    cellTemplate: '<div class="ngCellText" style="cursor:default;text-align: right;padding-right: 10px;"><span ng-cell-text>{{row.getProperty(col.field)|size}}</span></div>'
                },
                {
                    field: "provider", width: 80, displayName: '共享者',
                    cellTemplate: '<div class="ngCellText" style="cursor:default;"><span ng-cell-text>{{row.getProperty(col.field) }}</span></div>'
                },
                {
                    field: "shareDate", width: 160, displayName: '共享时间',
                    cellTemplate: '<div class="ngCellText" style="cursor:default;" ><span ng-cell-text>{{row.getProperty(col.field)}}</span></div>'
                }
            ]
        };
        $scope.selectRow = function (row, renderedRows) {
            if ($scope.event) {
                for (var i in renderedRows) {
                    renderedRows[i].selected = false;
                    renderedRows[i].orig.selected = false;
                }
                row.orig.selected = true;
                row.selected = true;
                $scope.gridOptions.selectedItems.splice(0, $scope.gridOptions.selectedItems.length);
                $scope.gridOptions.selectedItems.push(row.entity);
            }
        };
        $scope.onRightClick = function () {
            $scope.event = false;
        };
        $scope.Close = function () {
            $scope.event = true;
        };
        /**获取登录状态及个人信息**/
        sendRequest("/user/status.action", {}, function (data) {
            if (data.status == "login") {
                /**需要个人ID的所有操作，在这里执行**/
                $rootScope.status = data;
                $scope.id = -$rootScope.status.personGroupId;
                $scope.getResourceAsync($scope.pagingOptions.pageSize, ($scope.pagingOptions.currentPage - 1) * $scope.pagingOptions.pageSize);
            } else {
                $state.go("login");//如果没登陆则跳转到登录页
            }
        });
        $scope.getResourceAsync = function (pageSize, page) {
            $rootScope.progressbar.start();
            //获取资源列表
            sendRequest("/group/getMyReceiveResources.action",
                {limit: pageSize, start: page, memberId: 0}, function (data) {
                    $rootScope.progressbar.complete();
                    $scope.totalServerItems = data.totalCount;
                    $scope.pagingOptions.totalPage = Math.ceil($scope.totalServerItems / $scope.pagingOptions.pageSize);
                    $scope.data = data.resources;
                    $rootScope.thumbnail = [];
                    $rootScope.isBack=true;
                    $scope.breadcrumbpath = [{id: -$rootScope.status.personGroupId, displayName: "我的接收"}];
                    //$(".ngViewport ")[0].scrollTop = 0;
                    $scope.listOptions.parentId = data.parentId;
                    var imageId = [];
                    for (var i = 0; i < data.resources.length; i++) {
                        if (data.resources[i].type == 2) {
                            var fileName = data.resources[i].displayName;
                            var end = fileName.substring(fileName.lastIndexOf(".") + 1,
                                fileName.length).toLowerCase();
                            if (end == ("jpg") || end == ("gif") || end == ("png")
                                || end == ("jpeg") || end == ("bmp"))
                                imageId.push(data.resources[i].resourceId);
                        }
                    }
                    if (imageId.length > 0) {
                        sendRequest("/group/getThumbnail.action", {
                            width: 25,
                            height: 25,
                            quality: 0,
                            id: imageId
                        }, function (data) {
                            $rootScope.thumbnail = data;
                        });
                    }
                });
        };
        $scope.update = function () {
            $scope.gridOptions.selectedItems.splice(0, $scope.gridOptions.selectedItems.length);
            $scope.getResourceAsync($scope.pagingOptions.pageSize, ($scope.pagingOptions.currentPage - 1) * $scope.pagingOptions.pageSize);
        };
        $scope.getPagedDataAsync = function (pageSize, page, id) {
            if(id){
            $rootScope.progressbar.start();
            //获取资源列表
            sendRequest("/group/getResources.action",
                {parentId: id, type: "all", limit: pageSize, start: page}, function (data) {
                    $rootScope.progressbar.complete();
                    $scope.totalServerItems = data.totalCount;
                    $scope.pagingOptions.totalPage = Math.ceil($scope.totalServerItems / $scope.pagingOptions.pageSize);
                    $scope.data = data.resources;
                    $scope.breadcrumbpath = data.path;
                    if(data.path.length>1) $rootScope.isBack=false;else $rootScope.isBack=true;
                    //$(".ngViewport ")[0].scrollTop = 0;
                    $scope.listOptions.parentId = data.parentId;
                    $rootScope.thumbnail = [];
                    var imageId = [];
                    for (var i = 0; i < data.resources.length; i++) {
                        if (data.resources[i].type == 2) {
                            var fileName = data.resources[i].displayName;
                            var end = fileName.substring(fileName.lastIndexOf(".") + 1,
                                fileName.length).toLowerCase();
                            if (end == ("jpg") || end == ("gif") || end == ("png")
                                || end == ("jpeg") || end == ("bmp"))
                                imageId.push(data.resources[i].id);
                        }
                    }
                    if (imageId.length > 0) {
                        sendRequest("/group/getThumbnail.action", {
                            width: 25,
                            height: 25,
                            quality: 0,
                            id: imageId
                        }, function (data) {
                            $rootScope.thumbnail = data;
                        });
                    }
                });}
        };
        $rootScope.multiSelectDownload = function () {
            if ($scope.gridOptions.selectedItems.length > 0) {
                var selectedId = "";
                for (var x in $scope.gridOptions.selectedItems) {
                    selectedId = selectedId + ($scope.gridOptions.selectedItems[x].resourceId) + "&id="
                }
                selectedId = selectedId.substring(0, selectedId.length - 4);
                $scope.download(selectedId);
            }
        };
        $scope.recycle = function (id) {
            $rootScope.progressbar.start();
            sendRequest("/group/deleteReceivedResource.action",
                {id: id}, function (data) {
                    if (data.type == "success") {
                        $rootScope.progressbar.complete();
                        $scope.update();
                        $rootScope.toastr["success"]("删除成功！");
                    } else $rootScope.toastr["error"]("删除失败！");
                });
        };
        $scope.deleteFile = function (x) {
            modalConfirm.confirm({
                title: '是否删除 ' + x.displayName.replace(/(&nbsp;)/g, " ") + ' 这条接收内容 ?',
                onConfirm: function (data) {
                    $scope.recycle(x.id);
                },
                onCancel: function (data) {
                }
            });
        };
        $rootScope.multiSelectDelete = function () {
            if ($scope.gridOptions.selectedItems.length > 0)
                modalConfirm.confirm({
                    title: '是否删除这' + $scope.gridOptions.selectedItems.length + '条接收内容?',
                    onConfirm: function (data) {
                        var selectedId = [];
                        for (var x in $scope.gridOptions.selectedItems) {
                            selectedId.push($scope.gridOptions.selectedItems[x].id)
                        }
                        $scope.recycle(selectedId);

                    },
                    onCancel: function (data) {
                    }
                });
        };
        $scope.fileChain = function (id) {
            $scope.event = true;
            modalWindow.open({
                templateUrl: 'tpl/fileChain.html',
                controller: 'fileChainController',
                title: '文件外链',
                width: 600,
                height: 420,
                resolve: {
                    items: function () {
                        return id;
                    }
                }

            })
        };
        $scope.Email = function (id) {
            $scope.event = true;
            id.id = id.resourceId;
            modalWindow.open({
                templateUrl: 'tpl/email.html',
                controller: 'emailController',
                title: '邮件快递',
                width: 800,
                height: 530,
                resolve: {
                    items: function () {
                        return id;
                    }
                }

            })
        };
        $scope.moveCopy = function (x, title, y) {
            var id = [];
            if (y == 1) {
                id.push(x);
            }
            else {
                for (var i in $scope.gridOptions.selectedItems) {
                    id.push($scope.gridOptions.selectedItems[i].resourceId);
                }
            }
            if (id.length > 0) {
                modalWindow.open({
                    templateUrl: 'tpl/moveCopy.html',
                    controller: 'moveCopyController',
                    title: title,
                    width: 500,
                    height: 600,
                    resolve: {
                        items: function () {
                            return {"resourceId": id, "title": title, "scope": $scope};
                        }
                    }
                });
            }
        };
        $scope.$watch('pagingOptions.currentPage', function (newVal, oldVal) {
            if (newVal !== oldVal && newVal !== oldVal) {
                if ($rootScope.floor == 0)
                    $scope.getResourceAsync($scope.pagingOptions.pageSize, ($scope.pagingOptions.currentPage - 1) * $scope.pagingOptions.pageSize, $scope.listOptions.parentId, false);
                else $scope.getPagedDataAsync($scope.pagingOptions.pageSize, ($scope.pagingOptions.currentPage - 1) * $scope.pagingOptions.pageSize, $scope.listOptions.parentId, false);
            }
        });
        //下载资源
        $scope.download = function (id) {
            location.href = $rootScope.path + "/group/downloadResource.action?id=" + id;
        };


        $scope.rowOver = function () {
            this.isHidden = false;
        };
        $scope.rowLeave = function () {
            this.isHidden = true;
        };
        $scope.prev = function () {
            if ($scope.pagingOptions.currentPage == 1)
                return false;
            $scope.pagingOptions.currentPage--;
        };
        $scope.next = function () {
            if ($scope.pagingOptions.currentPage == $scope.pagingOptions.totalPage)
                return false;
            $scope.pagingOptions.currentPage++;
        };
        $scope.first = function () {
            $scope.pagingOptions.currentPage = 1;
        };
        $scope.end = function () {
            $scope.pagingOptions.currentPage = $scope.pagingOptions.totalPage;
        };
        $scope.title = function (data) {
            if (data.type == 1) {
                //$scope.download(data.resourceId)
                $scope.pagingOptions.currentPage = 1;
                if ($rootScope.floor == 0) {
                    $scope.getPagedDataAsync($scope.pagingOptions.pageSize, ($scope.pagingOptions.currentPage - 1) * $scope.pagingOptions.pageSize, data.resourceId);
                    $rootScope.floor++;
                }
                else {
                    $scope.getPagedDataAsync($scope.pagingOptions.pageSize, ($scope.pagingOptions.currentPage - 1) * $scope.pagingOptions.pageSize, data.id);
                    $rootScope.floor++;
                }
            }
            else if (data.type == 2) {
                $scope.download(data.resourceId);
                //var suffix = data.displayName.substring(data.displayName.lastIndexOf(".") + 1, data.displayName.length).toLowerCase();
                //if (suffix == "txt" || suffix == "doc" || suffix == "docx" || suffix == "pdf" || suffix == "ppt" || suffix == "pptx" || suffix == "xls" || suffix == "xlsx"){}
                // open($rootScope.path + "/onlineview.jsp?resId=" + data.resourceId + "&j=t");
            }
            else if (data.type == 3) {
                open(data.linkPath);
            }
        };
        $rootScope.back = function (id) {
            if ($rootScope.floor == 0) {

            } else if ($rootScope.floor == 1) {
                $scope.getResourceAsync($scope.pagingOptions.pageSize, ($scope.pagingOptions.currentPage - 1) * $scope.pagingOptions.pageSize);
                $rootScope.floor--;
            }
            else {
                $rootScope.progressbar.start();
                sendRequest("/group/getResources.action",
                    {
                        parentId: id,
                        back: true,
                        type: "all",
                        limit: $scope.pagingOptions.pageSize,
                        start: $scope.pagingOptions.start
                    }, function (data) {
                        $rootScope.progressbar.complete();
                        $scope.totalServerItems = data.totalCount;
                        $scope.pagingOptions.totalPage = Math.ceil($scope.totalServerItems / $scope.pagingOptions.pageSize);
                        $scope.data = data.resources;
                        $scope.breadcrumbpath = data.path;
                        if(data.path.length>1) $rootScope.isBack=false;else $rootScope.isBack=true;
                        $scope.listOptions.parentId = data.parentId;
                        $scope.pagingOptions.currentPage = 1;
                        $rootScope.thumbnail = [];
                        var imageId = [];
                        for (var i = 0; i < data.resources.length; i++) {
                            if (data.resources[i].type == 2) {
                                var fileName = data.resources[i].displayName;
                                var end = fileName.substring(fileName.lastIndexOf(".") + 1,
                                    fileName.length).toLowerCase();
                                if (end == ("jpg") || end == ("gif") || end == ("png")
                                    || end == ("jpeg") || end == ("bmp"))
                                    imageId.push(data.resources[i].id);
                            }
                        }
                        if (imageId.length > 0) {
                            sendRequest("/group/getThumbnail.action", {
                                width: 25,
                                height: 25,
                                quality: 0,
                                id: imageId
                            }, function (data) {
                                $rootScope.thumbnail = data;
                            });
                        }
                    });
                $rootScope.floor--;
            }
        };
        GridLayout.init();
    }]);
shareToMeController.filter('shareicon', function ($rootScope) {
    return function (icon) {
        if (icon.type == 1) {
            return "images/folder.png"
        } else if (icon.type == 2) {
            var end = icon.displayName.substring(icon.displayName.lastIndexOf(".") + 1,
                icon.displayName.length).toLowerCase();
            if (end == "zip" || end == "rar" || end == ("jar") || end == ("7z") || end == ("gz") || end == ("iso")) {
                return "images/zip.png";
            } else if (end == ("jpg") || end == ("gif") || end == ("png") || end == ("jpeg") || end == ("bmp")) {
                if ($rootScope.thumbnail.length > 0) {
                    for (var x in $rootScope.thumbnail) {
                        if (icon.resourceId == $rootScope.thumbnail[x].id || icon.id == $rootScope.thumbnail[x].id) {
                            return $rootScope.path + $rootScope.thumbnail[x].thumbUrl;
                        }
                    }
                }
                else return "images/image.png";
            } else if (end == ("m4a") || end == ("mp3") || end == ("mid") || end == ("xmf") || end == ("ogg") || end == ("wav")) {
                return "images/audio.png";
            } else if (end == "txt") {
                return "images/txt.png";
            } else if (end == ("pdf")) {
                return "images/pdf.png";
            } else if (end == ("doc") || end == ("docx")) {
                return "images/doc.png";
            } else if (end == ("xls") || end == ("xlsx")) {
                return "images/xls.png";
            } else if (end == ("ppt") || end == ("pptx")) {
                return "images/ppt.png";
            } else if (end == ("apk")) {
                return "images/apk.png";
            } else if (end == ("3gp") || end == ("mp4") || end == ("avi") || end == ("rmvb") || end == ("wmv") || end == ("mkv") || end == ("flv") || end == ("mpg")) {
                return "images/video.png"
            } else if (end == ("exe")) {
                return "images/exe.png";
            }
            else    return "images/default.png";
        }
        else if (icon.type == 3) {
            return "images/link.png";
        }
    }
});

/**主界面布局JS**/
var GridLayout = {
    init: function () {
        var _this = this;
        _this.resize();
        window.onresize = function () {
            _this.resize();
        }
    },
    resize: function () {

    }
};