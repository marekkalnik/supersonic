gulp = require "gulp"
sass = require "gulp-sass"
concat = require "gulp-concat"
browserify = require "gulp-browserify"
coffee = require "gulp-coffee"

buildConfig = require "../../config/buildConfig.coffee"

module.exports =
  sass: ->
    gulp.src("#{buildConfig.dir.sass}/supersonic.scss")
      .pipe(sass())
      .pipe(concat("supersonic.css"))
      .pipe(gulp.dest("#{buildConfig.dir.dist}/css"))
    gulp.src("#{buildConfig.dir.fonts}/*")
      .pipe(gulp.dest("#{buildConfig.dir.dist}/fonts/"))

  # Only the core supersonic experience
  core: ->
    gulp.src("#{buildConfig.dir.src}/supersonic/core.coffee", read: false)
      .pipe(browserify(
        transform: ['coffeeify']
        extensions: ['.coffee']
      ))
      .pipe(concat 'supersonic.core.js')
      .pipe(gulp.dest "#{buildConfig.dir.dist}")

  # Core plus Angular modules
  bundle: ->
    gulp.src("#{buildConfig.dir.src}/supersonic.coffee", read: false)
      .pipe(browserify(
        transform: ['coffeeify']
        extensions: ['.coffee']
      ))
      .pipe(concat 'supersonic.js')
      .pipe(gulp.dest "#{buildConfig.dir.dist}")

  # Just the Supersonic bootstrap
  bootstrap: ->
    gulp.src("#{buildConfig.dir.src}/supersonic.bootstrap.coffee")
      .pipe(coffee())
      .pipe(gulp.dest "#{buildConfig.dir.dist}")
