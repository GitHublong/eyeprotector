settings = require './settings.coffee'
mysql = require 'mysql'
client = null

hadleError = (err)->
	if err.code == 'PROTOCOL_CONNECTION_LOST'
		connection = mysql.createConnection(settings.db)
		connection.connect (err)->
			if err
				console.log "error when connecting to db:#{err}"
					
exports.getDbconnect = ()->
	console.log settings.db
	client = mysql.createConnection(settings.db)
	client.connect()
	#client.on('error',hadleError)
	console.log "getDb connect state:#{client.state}"
	return client

connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '   ',
  database : 'users'
})

connection.connect()

connection.query 'SELECT * FROM users',(err,result)->
	if err
		throw err
	console.log connection.state
	console.log result