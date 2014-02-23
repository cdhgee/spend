model = require "./model"

getData = (req, res, single) ->

  console.log req.params

  if model[req.query.object]? then model[req.query.object].call(null, req.params.api).then (data) ->
    success data, res, single

exports.index = (req, res) ->
  getData req, res, false

exports.show = (req, res) ->
  getData req, res, true

exports.new = (req, res) ->
  res.send()

exports.create = (req, res) ->



exports.edit = (req, res) ->
  res.send()

exports.update = (req, res) ->
  res.send()

exports.destroy = (req, res) ->
  res.send()

success = (data, res, single) ->
  jsonwrap data, res, single, "ok"

jsonwrap = (data, res, single, status) ->

  res.header "Cache-Control", "no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0"
  res.send
    status: status
    data: if single then data[0] else data

