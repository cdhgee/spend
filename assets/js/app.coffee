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

dataService = ($resource, $http) ->

  transformSpend = (data, headers) ->
    if typeof data.data.length is 'number'
      for idx, obj of data.data
        obj.date = moment obj.date, "X" if obj["id"]?
    else
      data.data.date = moment data.data.date, "X"

    data


  apiConfig =
    spend:
      object: "spend"
      callback: transformSpend
    people:
      object: "people"
    accounts:
      object: "accounts"
    categories:
      object: "categories"

  apis = {}

  for api,config of apiConfig

    object = config.object
    callback = config.callback

    apis[api] = do(object, callback) ->

      transformer = if callback? then $http.defaults.transformResponse.concat(callback) else $http.defaults.transformResponse

      $resource "/api/:id?object=:object", null,
        get:
          method: "GET"
          isArray: false
          params:
            object: object
          transformResponse: transformer
        index:
          method: "GET"
          isArray: false
          params:
            object: object
          transformResponse: transformer

  apis



spendApp.factory "Data", ["$resource", "$http", dataService]

spendApp.filter "formatdate", ->
  (input, format) ->
    formatted = if format == "" then input.format() else input.format format
    formatted

spendApp.filter "formatmoney", ->
  (input) ->
    accounting.formatMoney input

