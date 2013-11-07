user = require '../controller/user.coffee'
page = require '../controller/page.coffee'

# for key,value of page
# 	console.log "#{key} and #{value}"

# console.log page

module.exports = (app) ->
	app.get '/index',page.index
	app.get '/controller',page.controller
	app.get '/screen',page.screen
	app.get '/login',page.login
	app.post '/login',user.login
	app.get '/logout',user.logout
	app.get '/regist',page.regist
	app.post '/regist',user.regist
	app.get '/feedback',user.feedback
	app.get '/compare',user.compare
	
##中间判断用户是否登陆
checkLogin= (req,res,next)->
	if !req.session.user
		req.flash 'error','用户未登陆'
		res.redirect '/login'
	next()

checkLogout = (req,res,next)->
	if req.session.user
		req.flash 'error','用户已经登陆'
		res.redirect '/index'
	next()

