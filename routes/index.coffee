module.exports = (app) ->

  app.get "/", (req, res) ->
    res.render "index"

  app.get "/partials/*", (req, res) ->
    res.render "partials/#{req.params[0]}"

  app.resource "api", require "../api"

  #apis = ["spend", "people", "paymentmethods"]

  #app.resource "apis/#{api}", require "../apis/#{api}" for api in apis

  #app.resource "apis/spend", require "../apis/spend"
  #app.resource "apis/people", require "../apis/people"
  #app.resource "apis/paymentmethods", require "../apis/people"

  # THIS MUST BE THE LAST ENTRY
  app.get "*", (req, res) ->
    res.render "index"

