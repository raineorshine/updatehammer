exec = require('child_process').exec
async = require('async')
fomatto = require('nativity-fomatto').install()

# must reference cwd, otherwise it will always require updatehammer's package.json!
pkg = require(process.cwd() + '/package.json')
deps = Object.keys pkg.dependencies

async.series deps.map((dep)->
	(cb)->
		command = 'npm install {}@latest --save'.format(dep)
		console.log command
		exec command, (error, stdout, stderr) ->
			console.log stdout
			console.error stderr
			cb error
	), (err, results)->
		if err
			console.error 'exec error: ', err
		else
			console.log 'Successfully installed', deps.join(', ')
