class testSocket
	constructor:(@io)->
	run:->
		rooms = {}
		@io.sockets.on 'connection',(socket) ->
			@socket = socket
			# console.log socket
			console.log 'User Connected'
			socket.on 'disconnect',()->
				console.log 'User disconnect'

			socket.emit 'end',"try to judge end"

			socket.on 'end',(data)->
				console.log data
			socket.on 'end',(data)->
				console.log socket
				console.log 'receice end'
				console.log data.end
				if data.end is 'screen'
					console.log data.id
					socket.join "room#{data.id}",()->
						console.log "screen join #{data.id}"
				if data.end is 'controller'
					socket.join "room#{data.id}",()->
						console.log "controller join #{data.id}"
						console.log socket.id
						rooms[socket.id] = "room#{data.id}"
					console.log data.id

			socket.on 'select' ,(data)->
				console.log "#{data.direction}"
				
				socket.broadcast.to(rooms[data.id]).emit('judge',data)

module.exports = testSocket 