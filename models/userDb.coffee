##db = require '../database.coffee'
mysql = require 'mysql'
db= {}

db.getDbconnect= ()->
	client = mysql.createConnection({
	  host     : 'localhost',
	  user     : 'root',
	  password : '   ',
	  database : 'users'
	})
	client.connect (err)->
		console.log "connect:#{client.state}"
	return client

class user
	@client:db.getDbconnect()

	@create:(account,cb)->
		#cb remenber to close
		# if @client is null
		# 	@client = db.getDbconnect()
		@client.query 'INSERT INTO users SET ?',account,cb

	@change:(data,cb)->
		# if @client is null
		# 	@client = db.getDbconnect()
		@client.query 'UPDATE users SET ? WHERE id = ?',[data,data.id],cb

	@get:(account,cb)->

		console.log "get->#{account.account}"
		
		#unless @client
		#@client = db.getDbconnect()
		console.log @client.state
		console.log typeof cb
		#cb(null,"abc")
		query =  @client.query "SELECT * FROM users WHERE account = ?",[account.account],cb

		console.log "query is #{query.sql}"

	@delete:(id,cb)->
		# if @client is null
		# 	@client = db.getDbconnect()
		@client.query 'DELETE FROM USERS WHERE id = ?',[id],cb

	@getEyesight:(id,cb)->
		# if @client is null
		# 	@client = db.getDbconnect()
		sql = "SELECT eyesight FROM eyesights
	 	WHERE id= ? ORDER BY time DESC LIMIT 5"
		query = @client.query sql,[id],cb

		console.log query.sql

	@getTopEyestightsAndMe:(id,cb)->
		# if @client is null
		# 	@client = db.getDbconnect()
		sql = "SELECT eyesight,users.id,users.name FROM users,eyesights 
		WHERE users.id = eyesights.id OR users.id = ? 
		ORDER BY eyesight DESC LIMIT 10"
		@client.query sql,[id],cb

	@saveUserEyesight:(data,cb)->
		# if @client is null
		# 	@client = db.getDbconnect()
		sql = "UPDATE eyesights SET ? WHERE id = ?"
		@client.query sql,[data,data.id],cb
		
module.exports = user