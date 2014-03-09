pkg = require('./package.json')
exec = require('child_process').exec
async = require('async')
fomatto = require('nativity-fomatto').install()

deps = Object.keys pkg.dependencies
async.series deps.map((dep)->
	(cb)->
		command = 'pwd;npm install {}@latest --save'.format(dep)
		console.log command
		exec command, (error, stdout, stderr) ->
			console.log stdout
			console.error stderr
			cb error
	), (err, results)->
		if err
			console.error 'exec error: ', error
		else
			console.log 'Successfully installed', deps.join(', ')
