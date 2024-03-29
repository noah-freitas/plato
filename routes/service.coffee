qs = require 'qs'
https = require 'https'

# CMS Service Endpoint
exports.cms = (req, res) ->
  cmsUpdates =
    lessons: [
      {
        id: 1
        date: '01-14'
        pubDate: '2013-01-14'
        topic: 'Introduction'
      }, {
        id: 2
        date: '01-21'
        pubDate: '2013-01-21'
        topic: 'HTML5 Semantics and Structure'
      }, {
        id: 3
        date: '01-28'
        pubDate: '2013-01-28'
        topic: 'CSS3'
      }
    ]
    updated: Date()

  res.json cmsUpdates

# Feed Service Endpoint
exports.feed = (req, res) ->
  feedData =
    submissions: [
      {
        exercise: 1
        user: 'Noah Freitas'
        url: 'https://github.com/noah-freitas/learning-node-js/tree/master/1'
        date: '2013-01-21'
      }
    ]
  req.socket.setTimeout Infinity
  res.type 'text/event-stream'
  res.set 'Cache-Control', 'no-cache'
  res.write '\n'
  res.write 'id: 1\n'
  res.write "data: #{JSON.stringify feedData}\n\n"

# Mozilla Persona Authorization Endpoint
# Code adapted from the browserid cookbook Node/Express example.
# https://github.com/mozilla/browserid-cookbook
exports.auth = (req, res) ->
  onVerifyResp = (bidRes) ->
    data = ''
    bidRes.setEncoding 'utf8'
    bidRes.on 'data', (chunk) -> data += chunk
    bidRes.on 'end', ->
      verified = JSON.parse data
      res.contentType 'application/json'
      if verified.status is 'okay'
        req.session.email = verified.email
      else
        res.writeHead 403
      res.write data
      res.end()

  assertion = req.param 'assertion'

  body = qs.stringify
    assertion: assertion
    audience: 'http://socratesapp.herokuapp.com/'
    # audience: 'http://localhost:5000/'

  request = https.request
    host: 'verifier.login.persona.org'
    path: '/verify'
    method: 'POST'
    headers:
      'content-type': 'application/x-www-form-urlencoded'
      'content-length': body.length
  , onVerifyResp

  request.write body
  request.end()

# GitHub OAuth 2 authorization callback.
exports.githubAuthCallback = (req, res) ->
  code = req.query.code

  request = https.request
    host: 'github.com'
    path: '/login/oauth/access_token'
    method: 'POST'
    headers:
      'Accept': 'application/json'
  , (apiRes) ->
    data = ''
    apiRes.setEncoding 'utf8'
    apiRes.on 'data', (chunk) -> data += chunk
    apiRes.on 'end', ->
      console.log data
      res.end data

  request.write qs.stringify
    client_id: '95aadcd8f873bfb1dc5e'
    client_secret: 'b52a728b2396ffee36584f7fe0c4577efb84f245'
    code: code

  request.end()
