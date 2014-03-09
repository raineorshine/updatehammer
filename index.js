#!/usr/bin/env node
(function() {
  var async, deps, exec, fomatto, pkg;

  exec = require('child_process').exec;

  async = require('async');

  fomatto = require('nativity-fomatto').install();

  pkg = require(process.cwd() + '/package.json');

  deps = Object.keys(pkg.dependencies);

  async.series(deps.map(function(dep) {
    return function(cb) {
      var command;
      command = 'npm install {}@latest --save'.format(dep);
      console.log(command);
      return exec(command, function(error, stdout, stderr) {
        console.log(stdout);
        console.error(stderr);
        return cb(error);
      });
    };
  }), function(err, results) {
    if (err) {
      return console.error('exec error: ', err);
    } else {
      return console.log('Successfully installed', deps.join(', '));
    }
  });

}).call(this);
