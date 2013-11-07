class page
	@controller:(req,res)->
		res.render 'controller',{
			title:'Moblie Controller',
			id:req.session.user.id
		}

	@screen:(req,res)->
		res.render 'screen',{
			title:'Screen',
			id:req.session.user.id
		}
	@login:(req,res)->
		res.render 'login',{
			title:'login',
			error:req.flash 'error'
			}

	@regist:(req,res)->
		res.render 'regist',{
			title:'regist',
			error:req.flash 'error'
		}

	@index:(req,res)->
		res.render 'index',{
			title:'index',
			success:req.flash 'success'
		}
		
module.exports = page
# exports.controller = (req,res)->
# 	res.render 'controller',
# 	{title:'Moblie Controller'}