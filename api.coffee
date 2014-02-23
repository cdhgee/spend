model = require "./model"

getData = (req, res) ->

  console.log req.params

  if model[req.query.object]? then model[req.query.object].call(null, req.params.api).then (data) ->
    success data, res

exports.index = (req, res) ->
  getData req, res

exports.show = (req, res) ->
  getData req, res

exports.new = (req, res) ->
  res.send()

exports.create = (req, res) ->



exports.edit = (req, res) ->
  res.send()

exports.update = (req, res) ->
  res.send()

exports.destroy = (req, res) ->
  res.send()

success = (data, res) ->
  jsonwrap data, res, "ok"

jsonwrap = (data, res, status) ->

  res.header "Cache-Control", "no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0"
  res.send
    status: status
    data: data

