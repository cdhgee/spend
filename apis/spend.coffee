model = require "../model"

exports.index = (req, res) ->
  model.spend()
    .then (data) ->
      jsonwrap data, res

exports.new = (req, res) ->
  res.send()

exports.create = (req, res) ->

exports.show = (req, res) ->
  model.trx(req.params.spend).then (data) ->
    jsonwrap data, res


exports.edit = (req, res) ->
  res.send()

exports.update = (req, res) ->
  res.send()

exports.destroy = (req, res) ->
  res.send()

jsonwrap = (data, res) ->

  dict = {}
  dict[obj["id"]] = obj for obj in data when obj["id"]?

  res.header "Cache-Control", "no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0"
  res.send dict
