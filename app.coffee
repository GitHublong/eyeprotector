#
express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
mysql = require 'mysql'
testSocket = require './controller/testSocket.coffee'
app = express()
server = http.createServer app
io = require('socket.io').listen server
flash = require 'connect-flash'
redisStore = require('connect-redis')(express);

##all environments
app.set 'port', process.env.PORT || 3000 
app.set 'views', __dirname + '/views'
app.set 'view engine', 'ejs'
app.use express.favicon()
app.use express.logger 'dev' 
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.session({
	store: new redisStore({
		host:'localhost',
		db:1,
		port:6379,
		})
	,secret:'123456'
	})
app.use flash()
app.use app.router 
app.use express.static( path.join(__dirname, 'public'))


DATABASE = 'users'
TABLE = 'user'

connection = mysql.createConnection({
	host:'localhost',
	port:3306,
	user:'root',
	password:'   '
	})
connection.query "CREATE DATABASE #{DATABASE}",(err)->
	if err and err.number !=mysql.ERROR_DB_CREATE_EXITS
		throw err;
	else
		connection.query "USE #{DATABASE}"

server.listen app.get('port'),()->
	console.log 'Express server listening on port ' + app.get('port')
#development only
if 'development' is app.get 'env'
  app.use express.errorHandler()

routes app
#websocket
socket = new testSocket io
socket.run()