userDb = require '../models/userDb.coffee'

class user
	@regist:(req,res)->
		console.log "regist->"
		console.log req.body
		userDb.get req.body,(err,result)->
			console.log result
			if  result[0]
				req.flash 'error','account has been registed!'
				res.redirect '/regist'
			else
				userDb.create req.body,(err,result)->
					console.log result
					req.session.user = req.body
					req.flash 'success','regist success'
					res.redirect '/index'
	
	@login:(req,res)->
		#console.log req.body

		userDb.get req.body ,(err,result)->
			
			console.log result

			throw err if err 
			
			unless result[0]
				console.log 'account doesnt exit'
				req.flash 'error','account or password is not right!' 
				res.redirect '/login'

			if result[0].password isnt req.body.password
				console.log 'account password not right'
				req.flash 'error','account or password is not right!'
				res.redirect '/login'
			else
				req.flash 'success','Login success!'
				req.session.user = result[0]
				res.redirect '/index'

	@logout:(req,res)->
		req.session.user = null
		req.flash 'success','logou!'
		res.redirect '/index'
	
	@test:(req,res)->
		res.render '/test',{
			name:req.body.name
		}
	@feedback:(req,res)->
		userDb.getEyesight req.session.user.id ,(err,results)->
			console.log results
			res.render 'feedback',{
				title:'feedback',
				results:results
			}
	@compare:(req,res)->
		userDb.getTopEyestightsAndMe req.params.id,(err,results)->
			res.render 'compare',{
				title:'compare',
				results:results
			}


	@testComplete:(req,res)->
		userDb.saveUserEyesight req.body,(err,result)->
			req.flash 'success','Reflash eyesight'
			res.redirect '/index'


module.exports = user