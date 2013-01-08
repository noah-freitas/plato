express = require 'express'
path = require 'path'
services = require './routes/service'

# Set up Express App.
app = express()

app.configure ->
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session secret: 'your secret here'
  app.use app.router
  app.use express.static path.join __dirname, 'public'

app.get '/service/cms', services.cms
app.get '/service/feed', services.feed
app.get '/service/auth', services.auth

app.listen process.env.PORT
