var gulp = require('gulp'),
    sass = require('gulp-ruby-sass'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css'),
    jshint = require('gulp-jshint'),
    uglify = require('gulp-uglify'),
    imagemin = require('gulp-imagemin'),
    rename = require('gulp-rename'),
    clean = require('gulp-clean'),
    concat = require('gulp-concat'),
    cache = require('gulp-cache'),
    browserSync = require('browser-sync'),
    plumber = require('gulp-plumber');
    gutil = require('gulp-util');


/* error handling */

var onError = function (err) {  
  gutil.beep();
  console.log(err);
};  

/* browser-sync */ 

gulp.task('browser-sync', function() {
    browserSync({
        server: {
            baseDir: "./"
        },
        notify: false,
    });
});  


/* styles */

gulp.task('styles', function() {
    return gulp.src('scss/main.scss')
        .pipe(plumber({
            errorHandler: onError
        }))
        .pipe(sass({
            require: ['susy'],
            compass: true,
            "sourcemap=none": true,
        }))
        .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
        .pipe(rename({
            suffix: '.min',
            extname: '.css'
        }))
        .pipe(minifycss())
        .pipe(gulp.dest('css'))
        .pipe(browserSync.reload({stream:true}));
});



/* scripts */

gulp.task('scripts', function() {
    return gulp.src('js/main.js')
        .pipe(jshint('.jshintrc'))
        .pipe(jshint.reporter('default'))
        .pipe(rename({
            suffix: '.min'
        }))
        .pipe(uglify())
        .pipe(gulp.dest('js'))
        .pipe(browserSync.reload({stream:true}));;
});


gulp.task('bundle', function() {
    return gulp.src(['js/lib/jquery-1.11.1.min.js', 'js/lib/modernizr.js'])
        .pipe(concat('lib.js'))
        .pipe(rename({
            suffix: '.min'
        }))
        .pipe(uglify())
        .pipe(gulp.dest('js'));
});


/* images */
gulp.task('images', function() {
    return gulp.src('images/*.{jpg,png,jpeg}')
        .pipe(cache(imagemin({
            optimizationLevel: 7,
            progressive: true,
            interlaced: true
        })))
        .pipe(gulp.dest('images'));
});



/* clean */

gulp.task('clean', function() {
    return gulp.src(['css', 'js/min', 'images/dist'], {
            read: false
        })
        .pipe(clean());
});




/* default task */

gulp.task('default', ['clean', 'browser-sync'], function() {
    gulp.start('styles', 'scripts', 'images');
});



/* reload all browsers */

gulp.task('bs-reload', function () {
    browserSync.reload();
});



/* watch */

gulp.task('watch', ['browser-sync'], function() {

        // Watch .scss files
        gulp.watch('scss/**/*.scss', ['styles']);

        // Watch .js files
        gulp.watch('js/*.js', ['scripts']);

});