#!/usr/bin/env node
(function() {
  var async, cint, com, deps, devDeps, exec, filterDeps, fomatto, pkg, saveLatest;

  exec = require('child_process').exec;

  async = require('async');

  fomatto = require('nativity-fomatto').install();

  com = require('commander');

  cint = require('cint');

  saveLatest = function(depList, depFilter, options) {
    return async.series(depList.map(function(dep) {
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
        return console.log('Successfully installed', depList.join(', '));
      }
    });
  };

  com.option('-n, --filterName [expression]', 'Only update dependencies whose name matches the given regex', '.').option('-r, --filterVersion [expression]', 'Only update dependencies whose version matches the given regex', '.').parse(process.argv);

  filterDeps = function(deps, regex) {
    return cint.filterObject(deps, function(name, version) {
      return (new RegExp(com.filterName).test(name)) && (new RegExp(com.filterVersion).test(version));
    });
  };

  pkg = require(process.cwd() + '/package.json');

  deps = Object.keys(filterDeps(pkg.dependencies || {}));

  devDeps = Object.keys(filterDeps(pkg.devDependencies || {}));

  saveLatest(deps, '--save');

  saveLatest(devDeps, '--save-dev');

}).call(this);
