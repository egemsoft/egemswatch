/**
 * egemswatch
 * Boostrap theme based on Paper by Bootswatch.
 * @version 3.2.0 - 2014-09-22
 * @link http://egemsoft.github.io/egemswatch
 * @license Apache License, Version 2.0, http://www.apache.org/licenses/LICENSE-2.0
 */

module.exports = function(grunt) {
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-copy');


  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    builddir: '.',
    appConfig: {
      src: 'src',
      dist: '.'
    },
    meta: {
      banner: '/**\n' +
        ' * Egemswatch\n' +
        ' * <%= pkg.description %>\n' +
        ' * @version <%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        ' * @link <%= pkg.homepage %>\n' +
        ' * @license <%= pkg.license %>\n' +
        ' */'
    },
    clean: {
      build: {
        src: ['.sass-cache', 'src/build.concat.scss']
      },
      dist: {
        src: ['css', 'js', 'fonts']
      }
    },
    concat: {
      dist: {
        src: [],
        dest: ''
      }
    },
    sass: {
      dist: {
        options: {
          style: 'nested',
          banner: '<%= meta.banner %>'
        },
        files: {}
      }
    },
    copy: {
      bootstrap: {
        files: [
          // includes files within path
          {
            cwd: 'bower_components/bootstrap/dist',
            src: ['js/*', 'fonts/*'],
            dest: '<%= appConfig.dist %>',
            expand: true
          }
        ]
      }
    }
  });

  grunt.registerTask('build', function(compress) {
    var compress = compress == undefined ? true : compress;

    var concatSrc;
    var concatDest;
    var sassDest;
    var sassSrc;
    var files = {};
    var dist = {};
    concatSrc = '<%= appConfig.src %>/build.scss';
    concatDest = '<%= appConfig.src %>/build.concat.scss';
    sassDest = '<%= appConfig.dist %>/css/bootstrap.css';
    sassSrc = ['<%= appConfig.src %>/build.concat.scss'];

    dist = {
      src: concatSrc,
      dest: concatDest
    };
    grunt.config('concat.dist', dist);
    files = {};
    files[sassDest] = sassSrc;
    grunt.config('sass.dist.files', files);
    grunt.config('sass.dist.options.style', 'nested');

    grunt.task.run(['concat', 'sass:dist', 'clean:build',
      compress ? 'compress:' + sassDest + ':' + '<%= appConfig.dist %>/css/bootstrap.min.css' : 'none'
    ]);

    // copy js, font files
    grunt.task.run('copy:bootstrap');
  });

  grunt.registerTask('compress', 'compress a generic css', function(fileSrc, fileDst) {
    var files = {};
    files[fileDst] = fileSrc;
    grunt.log.writeln('compressing file ' + fileSrc);

    grunt.config('sass.dist.files', files);
    grunt.config('sass.dist.options.style', 'compressed');
    grunt.task.run(['sass:dist']);
  });

  grunt.registerTask('default', [
      'clean',
      'build'
    ]);

};