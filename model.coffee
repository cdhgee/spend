database = require "./database"

db = database "data.db"

module.exports.spend = ->

  db.query "spend_detail"
    .field "*"
    .select()

module.exports.trx = (id) ->

  db.query "spend_detail"
    .field "*"
    .where "id", "=", id
    .select()
