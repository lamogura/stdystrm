http           = require('http')
express        = require('express')
path           = require('path')
favicon        = require('serve-favicon')
logger         = require('morgan')
cookieParser   = require('cookie-parser')
bodyParser     = require('body-parser')
multer         = require('multer')
methodOverride = require('method-override')

routes = require('./routes/index')
users  = require('./routes/users')

app = express()

app.set('port', process.env.PORT or 3000)

# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));

app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use multer()
app.use methodOverride()
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))
app.use express.static(path.join(__dirname, 'semantic/dist'))

app.use('/', routes)
app.use('/users', users)

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next(err)

# error handlers

# development error handler, will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next) ->
    res.status(err.status or 500)
    res.render('error', { message: err.message, error: err })

# production error handler, no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status(err.status or 500)
  res.render('error', { message: err.message, error: {} })


http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')}"
  # console.log "Using database '#{dbinfo.name}' @ #{dbinfo.host}:#{dbinfo.port}"

module.exports = app