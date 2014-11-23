exec =    require('child_process').exec
async =   require('async')
fomatto = require('nativity-fomatto').install()
com =     require('commander')
cint =    require('cint')

saveLatest = (depList, options)->
	async.series depList.map((dep)->
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
				console.log 'Successfully installed', depList.join(', ')

com
  .option('-n, --filterName [expression]', 'Only update dependencies whose name matches the given regex', '.')
  .option('-r, --filterVersion [expression]', 'Only update dependencies whose version matches the given regex', '.')
  .parse(process.argv)

# filter a dependencies object (from package.json) down to only packages that match the given regular expressions
filterDeps = (deps, regex)->
	cint.filterObject deps, (name, version)->
		(new RegExp(com.filterName).test name) and
		(new RegExp(com.filterVersion).test version)

# must require package.json relative to cwd, otherwise it will always require updatehammer's package.json!
pkg = require(process.cwd() + '/package.json')
deps = Object.keys filterDeps pkg.dependencies or {}
devDeps = Object.keys filterDeps pkg.devDependencies or {}

# console.log pkg.dependencies, deps
# console.log pkg.devDependencies, devDeps
saveLatest deps, '--save'
saveLatest devDeps, '--save-dev'

