exec = require('child_process').exec
async = require('async')
fomatto = require('nativity-fomatto').install()

saveLatest = (deps, options)->
	async.series deps.map((dep)->
		(cb)->
			command = 'npm install {}@latest {}'.format(dep, options)
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


# must reference cwd, otherwise it will always require updatehammer's package.json!
pkg = require(process.cwd() + '/package.json')
deps = Object.keys pkg.dependencies
devDeps = Object.keys pkg.devDependencies

saveLatest deps, '--save'
saveLatest devDeps, '--save-dev'
