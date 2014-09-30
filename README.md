Egemswatch
----------

Bootstrap theme based on [Paper](http://bootswatch.com/paper) by Bootswatch. Derived from sass sources in [Bootswatch-sass](https://github.com/log0ymxm/bootswatch-scss).

![egemsoft-logo](http://egemsoft.net/images/logo.png)

##[Demo](https://rawgit.com/egemsoft/egemswatch/master/index.html)

##Usage

Install via bower:

```bash
 $ bower install egemswatch
```

Or download zip:
 - [master](https://github.com/egemsoft/egemswatch/archive/master.zip)

##Package Contents

```
├── css
│   ├── egemswatch.curious.css
│   ├── egemswatch.curious.min.css
│   ├── egemswatch.light-sea.css
│   ├── egemswatch.light-sea.min.css
│   ├── egemswatch.madison.css
│   ├── egemswatch.madison.min.css
│   ├── egemswatch.ming.css
│   ├── egemswatch.ming.min.css
│   ├── egemswatch.steel.css
│   └── egemswatch.steel.min.css
├── fonts
│   ├── glyphicons-halflings-regular.eot
│   ├── glyphicons-halflings-regular.svg
│   ├── glyphicons-halflings-regular.ttf
│   └── glyphicons-halflings-regular.woff
└── js
    ├── bootstrap.js
    └── bootstrap.min.js
```

##Development

Node, npm, Bower and Grunt is required for development.

###Install

```bash
 $ npm install
 $ bower install
```

###Build

Default task runs buildThemes task which generates css files with sass sources. Packages css, font and js files on corresponding directories. Requires bootstrap and bootstrap-sass-official (installed with bower).

```bash
 $ grunt
```

##Author

İsmail Demirbilek, [@dbtek](https://twitter.com/dbtek)

##License

- Egemswatch is published under [MIT](http://opensource.org/licenses/MIT) license.
- [Bootswatch-scss](https://github.com/log0ymxm/bootswatch-scss) is licensed under APACHE-2.0 license.