express = require 'express'
path = require 'path'
services = require './routes/service'

# Set up Express App.
app = express()

app.configure ->
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use app.router
  app.use express.static path.join __dirname, 'public'

app.get '/service/cms', services.cms
app.get '/service/feed', services.feed

app.listen process.env.PORT
