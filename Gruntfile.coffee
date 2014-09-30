#!
# egemswatch
# Boostrap theme based on Paper by Bootswatch.
# @version 3.2.0 - 2014-09-22
# @link http://egemsoft.github.io/egemswatch
# @license MIT, http://opensource.org/licenses/MIT
#

module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-copy'


  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    builddir: '.'

    appConfig:
      src: 'src'
      dist: '.'
      themes: [
        'curious',
        'light-sea'
        'madison'
        'ming'
        'steel'
      ]


    meta:
      banner: '/**\n' +
        ' * Egemswatch\n' +
        ' * <%= pkg.description %>\n' +
        ' * @version <%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        ' * @link <%= pkg.homepage %>\n' +
        ' * @license <%= pkg.license %>\n' +
        ' */'

    clean:
      build:
        src: ['.sass-cache', 'src/build.concat.scss']
      dist:
        src: ['css', 'js', 'fonts']
  
    concat:
      dist:
        src: [],
        dest: ''

    sass:
      dist:
        options:
          style: 'nested',
          banner: '<%= meta.banner %>'
        files: {}

    copy:
      bootstrap:
        files: [
          # includes files within path
          cwd: 'bower_components/bootstrap/dist'
          src: ['js/*', 'fonts/*']
          dest: '<%= appConfig.dist %>'
          expand: true
        ]


  # Build single theme
  grunt.registerTask 'build', (theme, compress) ->
    compress = true if !compress?;
    files = {}
    dist = {}
    concatSrc = ["<%= appConfig.src %>/egemswatch.#{ theme }.scss", '<%= appConfig.src %>/build.scss']
    concatDest = '<%= appConfig.src %>/build.concat.scss'
    sassDest = "<%= appConfig.dist %>/css/egemswatch.#{ theme }.css"
    sassSrc = ['<%= appConfig.src %>/build.concat.scss']

    dist =
      src: concatSrc,
      dest: concatDest

    grunt.config 'concat.dist', dist
    files = {}
    files[sassDest] = sassSrc
    grunt.config 'sass.dist.files', files
    grunt.config 'sass.dist.options.style', 'nested'

    grunt.task.run [
      'concat'
      'sass:dist'
      'clean:build'
    ]

    grunt.task.run "compress: #{ sassDest }:<%= appConfig.dist %>/css/egemswatch.#{ theme }.min.css" if compress


  # Build all themes registered on appConfig.themes
  grunt.registerTask 'buildThemes', (compress) ->
    grunt.config.get('appConfig.themes').forEach (theme) ->
      grunt.task.run "build:#{ theme }:#{ compress }"


  grunt.registerTask 'compress', 'compress a generic css', (fileSrc, fileDst) ->
    files = {}
    files[fileDst] = fileSrc
    grunt.log.writeln 'compressing file ' + fileSrc

    grunt.config 'sass.dist.files', files
    grunt.config 'sass.dist.options.style', 'compressed'
    grunt.task.run ['sass:dist']


  grunt.registerTask 'default', [
      'clean',
      'buildThemes',
      # copy js, font files
      'copy:bootstrap'
    ]