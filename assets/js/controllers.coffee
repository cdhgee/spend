controllers = angular.module "Controllers", ["ngResource", "ngGrid", "ui.bootstrap"]

spendController = controllers.controller "SpendController", ($scope, $resource, Data, $modal) ->

  $scope.spendData = {}

  Data.spend.index().then (spendData) ->
    console.log spendData
    $scope.spendData = spendData.data

  $scope.edit = (rowid) ->

    modalInstance = $modal.open
      templateUrl: "/partials/spend-editor"
      controller: spendEditorController

      resolve:
        item: ->
          $scope.spendData[rowid]

    modalInstance.result.then (selectedItem) ->
      $scope.selected = selectedItem
    , angular.noop



spendEditorController = ($scope, $modalInstance, item, Data) ->

  $scope.item = item

  $scope.people = {}

  Data.people.index().then (data) ->
    $scope.people = data.data

  Data.accounts.index().then (data) ->
    $scope.accounts = data.data

  $scope.ok = ->
    $modalInstance.close $scope.item

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"

  $scope.datepicker = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()

    $scope.opened = true

budgetController = controllers.controller "BudgetController", ($scope) ->

  $scope.spend = [2,3]

