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
  grunt.loadNpmTasks 'grunt-contrib-less'
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
        src: ['src/less/build.concat.less']
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
          src: ['js/bootstrap.*', 'fonts/*']
          dest: '<%= appConfig.dist %>'
          expand: true
        ]


  # Build single theme
  grunt.registerTask 'build', (theme, compress) ->
    compress = false if !compress?
    files = {}
    dist = {}
    concatSrc = ["<%= appConfig.src %>/less/egemswatch.#{ theme }.less", '<%= appConfig.src %>/less/build.less']
    concatDest = '<%= appConfig.src %>/less/build.concat.less'
    lessDest = "<%= appConfig.dist %>/css/egemswatch.#{ theme }.css"
    lessSrc = ['<%= appConfig.src %>/less/build.concat.less']

    dist =
      src: concatSrc,
      dest: concatDest

    grunt.config 'concat.dist', dist
    files = {}
    files[lessDest] = lessSrc
    grunt.config 'less.dist.files', files

    grunt.task.run [
      'concat'
      'less:dist'
      'clean:build'
    ]

    grunt.task.run "compress: #{ lessDest }:<%= appConfig.dist %>/css/egemswatch.#{ theme }.min.css" if compress


  # Build all themes registered on appConfig.themes
  grunt.registerTask 'buildThemes', (compress) ->
    grunt.config.get('appConfig.themes').forEach (theme) ->
      grunt.task.run "build:#{ theme }:#{ compress }"


  grunt.registerTask 'compress', 'compress a generic css', (fileSrc, fileDst) ->
    files = {}
    files[fileDst] = fileSrc
    grunt.log.writeln 'compressing file ' + fileSrc

    grunt.config 'less.dist.files', files
    grunt.config 'less.dist.options.style', 'compressed'
    grunt.task.run ['less:dist']


  grunt.registerTask 'default', [
      'clean',
      'buildThemes',
      # copy js, font files
      'copy:bootstrap'
    ]