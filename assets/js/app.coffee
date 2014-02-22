spendApp = angular.module "SpendApp", ["ngRoute", "Controllers"]

spendConfig = ($routeProvider) ->
  $routeProvider
    .when "/spend",
      templateUrl: "partials/spend"
      controller: "SpendController"
    .when "/budget",
      templateUrl: "partials/budget"
      controller: "BudgetController"
    .otherwise
      redirectTo: "/spend"

spendApp.config ["$routeProvider", spendConfig]

dataService = ($resource) ->

  passCallback = (data) ->
    data

  api = (obj, callback) ->

    if not callback? then callback = passCallback

    resource = do(obj) ->

      $resource "/api/:id?object=:object", null,
        _get:
          method: "GET"
          isArray: false
          params:
            object: obj
        _index:
          method: "GET"
          isArray: false
          params:
            object: obj

    resource.get = (id) ->
      resource._get(id).$promise.then callback

    resource.index = ->
      resource._index().$promise.then callback

    resource

  transformSpend = (data) ->
    for idx, obj of data.data
      obj.date = moment obj.date, "X" if obj["id"]?
    data


  data =
    spend: api "spend", transformSpend
    people: api "people"
    accounts: api "accounts"


spendApp.factory "Data", ["$resource", dataService]

spendApp.filter "formatdate", ->
  (input, format) ->
    formatted = if format == "" then input.format() else input.format format
    formatted

spendApp.filter "formatmoney", ->
  (input) ->
    accounting.formatMoney input

