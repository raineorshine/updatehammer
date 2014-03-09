(function() {
  var async, deps, exec, fomatto, pkg;

  pkg = require('./package.json');

  exec = require('child_process').exec;

  async = require('async');

  fomatto = require('nativity-fomatto').install();

  deps = Object.keys(pkg.dependencies);

  async.series(deps.map(function(dep) {
    return function(cb) {
      var command;
      command = 'pwd;npm install {}@latest --save'.format(dep);
      console.log(command);
      return exec(command, function(error, stdout, stderr) {
        console.log(stdout);
        console.error(stderr);
        return cb(error);
      });
    };
  }), function(err, results) {
    if (err) {
      return console.error('exec error: ', error);
    } else {
      return console.log('Successfully installed', deps.join(', '));
    }
  });

}).call(this);
