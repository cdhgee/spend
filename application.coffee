express = require "express"
connectassets = require "connect-assets"
require "express-resource"

app = express()


app.configure ->
  app.use express.logger()
  app.set "view engine", "jade"
  app.locals.pretty = true
  app.use express.static "#{__dirname}/assets"
  app.use connectassets
    helperContext: app.locals
  app.use express.urlencoded()
  app.use express.json()
  app.use express.methodOverride()


app.configure "development", ->
  app.use express.errorHandler ->
    dumpExceptions: true,
    showStack: true

routes = require "./routes/index"
routes(app)

app.listen 3000, ->
  console.log "Express server listening on port %d in %s mode", @address().port, app.settings.env
