/**
 * Created by lfn on 2015/12/21.
 */
angular.module("renameController", ["am.modal"])
    .controller('renameController', ["$scope","$rootScope", '$modalInstance', 'items', "httpRequest.sendRequest", function ($scope,$rootScope, $modalInstance, items, sendRequest) {
        $scope.data = {};
        if(items.name.lastIndexOf(".")>0)
        $scope.data.newname = items.name.substring(0, items.name.lastIndexOf(".")).replace(/(&nbsp;)/g, " ");
        else $scope.data.newname = items.name.replace(/(&nbsp;)/g, " ");
        $scope.data.desc = items.desc.replace(/(&nbsp;)/g, " ");
        $scope.data.priority=items.priority;
        $scope.renameConfirm = function () {
            $rootScope.progressbar.start();
            sendRequest("/group/modifyResource.action", {
                id: items.id,
                name: $scope.data.newname,
                desc:  $scope.data.desc
            }, function (data) {
                $rootScope.progressbar.complete();
                if (data.type == "success") {
                    items.scope.update();
                    $rootScope.toastr["success"]("修改成功！");
                } else   $rootScope.toastr["error"]("修改失败！");
            });
            sendRequest("/group/modifyResourceOrder.action", {
                id: items.id,
                orders: $scope.data.priority
            }, function (data) {
                if (data.type == "success") {
                    items.scope.update();
                }
            });
        }
    }]);