/**
 * Created by lfn on 2015/12/29.
 */
angular.module("modifyAccountController", ["am.modal"])
    .controller('modifyAccountController',["$scope","$rootScope",'$modalInstance','items',"httpRequest.sendRequest",function($scope,$rootScope,$modalInstance,items,sendRequest){
console.log(items);
        $scope.data={};
        $scope.data.name=items.userdata.name;
        $scope.data.company=items.userdata.company;
        $scope.data.department=items.userdata.department;
        $scope.data.email=items.userdata.email;
        $scope.data.mobile=items.userdata.mobile;
        $scope.data.phone=items.userdata.phone;
        $scope.data.im=items.userdata.im;
        $scope.modifyBtn=function(){
            $rootScope.progressbar.start();
            sendRequest("/user/modifyAccount.action", {
                name:  $scope.data.name,
                company:$scope.data.company,
               department:$scope.data.department,
                mobile: $scope.data.mobile,
                phone: $scope.data.phone,
                email: $scope.data.email,
                im:$scope.data.im
            }, function (data) {
                $rootScope.progressbar.complete();
                if (data.type == "success") {
                    items.getAccount();
                    $rootScope.toastr["success"]("修改成功！");
                } else   $rootScope.toastr["error"]("修改失败！");
            });
            $modalInstance.close();
        };
        $scope.cancel=function(){
            $modalInstance.close();
        }
    }]);