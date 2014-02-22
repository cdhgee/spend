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

genericQuery = (table, id) ->

  q = db.query table
    .field "*"

  if id?
    q = q.where "id", "=", id

  q.select()

module.exports.people = (id) ->

  q = db.query "people"
    .field "*"

  if id?
    q = q.where "id", "=", id

  q.select()


module.exports.paymentmethods = (id) ->

  genericQuery "paymentmethods", id
