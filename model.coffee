database = require "./database"

db = database "data.db"

genericQuery = (table, id) ->

  q = db.query table
    .field "*"

  if id?
    q = q.where "id", "=", id

  q.select()

apis =
  accounts: "paymentmethods"
  spend: "spend_detail"
  people: "people"

for api, dbobj of apis
  module.exports[api] = do (dbobj) ->
    (id) ->
      genericQuery dbobj, id
