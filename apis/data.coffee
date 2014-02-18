model = require "../model"

exports.index = (req, res) ->
  model.spend()
    .then (data) ->
      res.header "Cache-Control", "no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0"
      res.send data

#exports.new = (req, res) ->

#exports.create = (req, res) ->

exports.show = (req, res) ->
  console.log req.params
  ###
  model.trx req.params.spend
    .then (data) ->
      res.header "Cache-Control", "no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0"
      res.send data
  ###
  console.log req
  res.send [1,2,3]



#exports.edit = (req, res) ->

#exports.update = (req, res) ->

#exports.destroy = (req, res) ->
