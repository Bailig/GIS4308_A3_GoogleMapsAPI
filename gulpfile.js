var gulp = require('gulp'),
    gutil = require('gulp-util'),
    compass = require('gulp-compass'),
    concat = require('gulp-concat'),
    browserify = require('gulp-browserify');

var sassSources = ['component/sass/style.scss'];
var jsSources = ['component/script/map1.js',
                'component/script/moreinfo.js'];

gulp.task('compass',function(){
    gulp.src(sassSources)
    .pipe(compass({
        sass: 'component/sass',
        image:'build/development/image',
        style:'expanded'
    })
         .on('error',gutil.log))
    .pipe(gulp.dest('build/development/css'))
});

gulp.task('js',function(){
    gulp.src(jsSources)
    .pipe(concat('script.js'))
    .pipe(gulp.dest('build/development/js'))
});

gulp.task('watch',function(){
    gulp.watch(['component/sass/*.scss','component/sass/module/*.scss'],['compass']);
    gulp.watch(jsSources,['js'])
});
