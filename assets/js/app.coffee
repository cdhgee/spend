spendApp = angular.module "SpendApp", ["ngRoute", "Controllers"]

spendApp.config ["$routeProvider", ($routeProvider) ->
  $routeProvider
    .when "/spend",
      templateUrl: "partials/spend"
      controller: "SpendController"
    .when "/budget",
      templateUrl: "partials/budget"
      controller: "BudgetController"
    .otherwise
      redirectTo: "/spend"
]


spendApp.factory "Spend", ["$resource", ($resource) ->

    $resource "/apis/spend/:id", null,
      get:
        method: "GET"
        isArray: false
      list:
        method: "GET"
        isArray: false
        params: {}

]

spendApp.filter "formatdate", ->
  (input, format) ->
    date = moment input, "X"
    formatted = if format == "" then date.format() else date.format format
    formatted

spendApp.filter "formatmoney", ->
  (input) ->
    accounting.formatMoney input

