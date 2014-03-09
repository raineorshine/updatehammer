exec = require('child_process').exec
chai = require('chai')
async = require('async')
should = chai.should()

# commands = [
# 	'mkdir temp'
# 	'touch temp/a'
# 	'touch temp/b'
# ]

# execFull = (command, cb)->
# 	exec command, (error, stdout, stderr) ->
# 		console.log stdout
# 		console.error stderr
# 		cb error, stdout

# commandSeries = (commands)->
# 	commands.map (command)->
# 		(cb)->
# 			exec command, cb

# describe 'updatehammer', ->
# 	it 'should do a bunch of commands', (done)->
# 		async.series commandSeries(commands), (err, results)->
# 			done err
