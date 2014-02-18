controllers = angular.module "Controllers", ["ngResource", "ngGrid", "ui.bootstrap"]

spendController = controllers.controller "SpendController", ($scope, $resource, Spend, $modal) ->

  #$scope.Spend = $resource "/apis/data",
  #console.log "getting data"
  #
  $scope.spendData = []

  Spend.list().$promise.then (spendData) ->
    $scope.spendData = spendData

  $scope.edit = (rowid) ->

    console.log rowid
    console.log $scope.spendData[rowid]

    modalInstance = $modal.open
      templateUrl: "/partials/spend-editor"
      controller: ($scope, $modalInstance, item) ->
        $scope.item = item

        $scope.ok = ->
          $modalInstance.close $scope.item

        $scope.cancel = ->
          $modalInstance.dismiss "cancel"

      resolve:
        item: ->
          $scope.spendData[rowid]

    modalInstance.result.then (selectedItem) ->
      $scope.selected = selectedItem
    , ->
      console.log "Modal dismissed"


budgetController = controllers.controller "BudgetController", ($scope) ->

  $scope.spend = [2,3]

