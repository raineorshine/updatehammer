#!/usr/bin/env node
(function() {
  var async, deps, devDeps, exec, fomatto, pkg, saveLatest;

  exec = require('child_process').exec;

  async = require('async');

  fomatto = require('nativity-fomatto').install();

  saveLatest = function(deps, options) {
    return async.series(deps.map(function(dep) {
      return function(cb) {
        var command;
        command = 'npm install {}@latest {}'.format(dep, options);
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
  };

  pkg = require(process.cwd() + '/package.json');

  deps = Object.keys(pkg.dependencies || {});

  devDeps = Object.keys(pkg.devDependencies || {});

  saveLatest(deps, '--save');

  saveLatest(devDeps, '--save-dev');

}).call(this);
