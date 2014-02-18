"use strict"

q = require "q"
sqlite3 = require "sqlite3"

class Database
  constructor: (@filename) ->
    @open()

  open: () ->
    @db = new sqlite3.Database @filename

  close: () ->
    @db.close()

  all: (args...) ->
    q.npost @db, "all", args
    #@dbfunc "all", args

  execute: (args...) ->
    q.npost @db, "run", args
    #@dbfunc "run", args


  #dbfunc: (func, args) ->
  #  q.npost(@db, func, args)

  query: (select) ->
    new DatabaseQuery @, select

class DatabaseQuery
  constructor: (@db, @select_view) ->
    @query =
      fields: []
      where: []
      orderby: []
      groupby: []

  field: (field, alias="", aggregate=null, value=null) ->
    @query.fields.push
      name: field
      alias: alias
      aggregate: aggregate
      value: value
    @

  where: (field, operator, value) ->
    @query.where.push
      name: field
      operator: operator
      value: value
    @

  orderby: (field, direction) ->
    @query.orderby.push
      name: field
      direction: direction
    @

  groupby: (field) ->
    @query.groupby.push field
    @

  single_field: (field) ->
    if field.aggregate is null
      "#{field.name} #{field.alias}"
    else
      "#{field.aggregate}(#{field.name}) #{field.alias}"

  field_clause: ->
    [@single_field field for field in @query.fields].join ", "

  values: ->
    [field.value for field in @query.fields]

  placeholders: ->
    ["?" for field in @query.fields].join ", "

  where_clause: ->
    @generic_clause @query.where, "WHERE", " AND ", (field) ->
      "#{field.name} #{field.operator} ?"

  where_values: ->
    field.value for field in @query.where

  orderby_clause: ->
    @generic_clause @query.orderby, "ORDER BY", ", ", (field) ->
      "#{field.name} #{field.direction}"

  groupby_clause: ->
    @generic_clause @query.groupby, "GROUP BY", ", ", (field) ->
      field

  generic_clause: (data, kw, joiner, formatter) ->
    if data.length > 0 then "#{kw} #{("#{formatter field}" for field in data).join(joiner)}" else ""

  select: ->
    console.log "SELECT #{@field_clause()} FROM #{@select_view} #{@where_clause()} #{@orderby_clause()} #{@groupby_clause()} #{@where_values()}"
    console.log @where_values()
    @db.all "SELECT #{@field_clause()} FROM #{@select_view} #{@where_clause()} #{@orderby_clause()} #{@groupby_clause()}", @where_values()

  insert: ->
    @db.all "INSERT INTO #{@select_view}(#{@field_clause()}) VALUES (#{@placeholders()})", @values()...

  delete: ->
    @db.all "DELETE FROM #{@select_view} #{@where_clause()}", @where_values()...




module.exports = (dbname) ->
  new Database dbname
