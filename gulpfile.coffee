gulp = require('gulp') 

buildSemantic = require('./semantic/tasks/build')
cleanSemantic = require('./semantic/tasks/clean')
watchSemantic = require('./semantic/tasks/watch')

gulp.task('watch', watchSemantic)
gulp.task('build', buildSemantic)
gulp.task('clean', cleanSemantic)

gulp.task('default', ['watch'])
