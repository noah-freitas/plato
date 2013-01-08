express = require 'express'
path = require 'path'

# Set up Express App.
app = express()

app.configure ->
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use app.router
  app.use express.static path.join __dirname, 'public'

app.listen process.env.PORT
