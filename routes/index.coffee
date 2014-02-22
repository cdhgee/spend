module.exports = (app) ->

  app.get "/", (req, res) ->
    res.render "index"

  app.get "/partials/*", (req, res) ->
    res.render "partials/#{req.params[0]}"

  app.resource "api", require "../api"

  # THIS MUST BE THE LAST ENTRY
  app.get "*", (req, res) ->
    res.render "index"

