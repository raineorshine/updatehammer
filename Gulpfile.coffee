gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
clean = require('gulp-clean')

gulp.task 'scripts', ->
	gulp.src('src/*.coffee')
		.pipe(coffee().on('error', gutil.log))
		.pipe gulp.dest('./')

gulp.task 'watch', ->
	gulp.watch ['src/**/*.coffee'], ['scripts']

gulp.task 'clean', ->
	gulp.src('temp', { read: false })
		.pipe(clean())

gulp.task 'default', ['scripts', 'clean']