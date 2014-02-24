controllers = angular.module "Controllers", ["ngResource", "ngGrid", "ui.bootstrap"]

spendController = ($scope, $resource, Data, $modal) ->

  $scope.spendData = {}

  Data.spend.index().$promise.then (spendData) ->
    console.log spendData
    $scope.spendData = spendData.data

  $scope.edit = (rowid) ->

    modalInstance = $modal.open
      templateUrl: "/partials/spend-editor"
      controller: spendEditorController

      resolve:
        id: ->
          rowid

    modalInstance.result.then (selectedItem) ->
      $scope.selected = selectedItem
    , angular.noop


controllers.controller "SpendController", spendController

spendEditorController = ($scope, $modalInstance, id, Data) ->

  Data.spend.get
    id: id
  .$promise.then (item) ->
    $scope.item = item.data

  $scope.people = {}
  $scope.datepickeropened = false

  Data.people.index().$promise.then (data) ->
    $scope.people = data.data

  Data.accounts.index().$promise.then (data) ->
    $scope.accounts = data.data

  Data.categories.index().$promise.then (data) ->
    $scope.categories = data.data

  $scope.ok = ->
    $modalInstance.close $scope.item

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"

  $scope.opendatepicker = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()

    $scope.datepickeropened = true


budgetController = controllers.controller "BudgetController", ($scope) ->

  $scope.spend = [2,3]

