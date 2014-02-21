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

  api = (url, callback) ->

    if not callback? then callback = passCallback

    resource = $resource url, null,
      _get:
        method: "GET"
        isArray: false
      _index:
        method: "GET"
        isArray: false
        params: {}

    resource.get = (id) ->
      resource._get(id).$promise.then callback

    resource.index = ->
      resource._index().$promise.then callback

    resource

  transformSpend = (data) ->
    for idx, obj of data
      obj.date = moment obj.date, "X" if obj["id"]?
    data


  data =
    spend: api "/apis/spend/:id", transformSpend
    people: api "/apis/people/:id"


spendApp.factory "Data", ["$resource", dataService]
###
spendApp.factory "Spend", ["$resource", ($resource) ->


  res = $resource "/apis/spend/:id", null,
    get:
      method: "GET"
      isArray: false
    _list:
      method: "GET"
      isArray: false
      params: {}

  res.list = ->
    res._list.apply res, arguments
      .$promise.then (res2) ->
        for idx, obj of res2
          obj.date = moment obj.date, "X" if obj["id"]?

        res2

  res


]
spendApp.factory "People", ["$resource", ($resource) ->

  res = $resource "/apis/people/:id", null,
    get:
      method: "GET"
      isArray: false
    list:
      method: "GET"
      isArray: false
      params: {}

]
###

spendApp.filter "formatdate", ->
  (input, format) ->
    formatted = if format == "" then input.format() else input.format format
    formatted

spendApp.filter "formatmoney", ->
  (input) ->
    accounting.formatMoney input

