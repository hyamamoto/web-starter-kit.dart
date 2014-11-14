# [Web Starter Kit　for Dart](http://github.com/hyamamoto/web-starter-kit.dart)

 ( [**wsk**](https://pub.dartlang.org/packages/wsk) in pub repository )

_version 0.5.1 (11/14/2014)_ <!-- [![Build Status](https://drone.io/github.com/hyamamoto/material.dart/status.png)](https://drone.io/github.com/hyamamoto/wsk.dart/latest) -->
	
## Overview

**Web Starter Kit　for Dart ( wsk )** is a Dart pub package which is also an asset and template pack. It's made for kick-starting a Dart project for [Web Starter Kit](http://developers.google.com/web/starter-kit) without a hussle.

## Quick Start

Within the Dart Editor...

1. Create a new empty project.
2. Open `pubspec.yaml` and add **wsk** package. Save it.
3. Select `Tools > Pub Get` from the application menu.
4. Copy 2 directories inside `/{project_dir}/packages/wsk/templates` to your project root.
   This can be done by a simple drag & drop.
5. Right-click `/{project_dir}/web/index.html`. Select `Run in Dartium`.

Then, you'll see the working web page on your browser!

<!-- Also, you can clone this repository and build on what is included in the `web` directory. -->


## Features 

#### What **wsk** package provides...

* Pre-built static resources from Web Starter Kit
    - CSS, Fonts, and Images
    - SaSS source files
* A Dart project template
* Dart utility methods
    - Routing methods
    - Transformer for release build (URL rewriting)

#### What **wsk** package _does not_ provides...

* Web application framework
    - Utility methods are provided, But they're always for optional use.
* UI components framework  
    - Won't be here to keep this package light-weight. Use [polymer.dart](https://www.dartlang.org/polymer/) if you prefer a complete UI framework.
* SaSS auto-compiling setup  
    - SaSS, I think, requires some effort to run which defeats the purpose of this package being a "Starter Kit". <!-- Some people doesn't have SaSS enabled environment. -->

<!--
### API Document

* http://htmlpreview.github.io/?https://github.com/hyamamoto/web-starter-kit.dart/blob/master/docs/index.html
-->


## Package structure



<pre>
packages
└── wsk
    ├── assets
    │   ├── fonts
    │   ├── images
    │   ├── scripts
    │   └── styles
    │       ├── components.css
    │       ├── components.min.css
    │       ├── main.css
    │       └── main.min.css
    ├── sass
    │   ├── components
    │   │   └── components.sass
    │   └── main.sass
    ├── templates
    │   ├── tests
    │   └── web
    │       ├── index.dart
    │       ├── index.html
    │       ├── styleguide.dart
    │       └── styleguide.html
    ├── routing_utils.dart
    ├── transformer.dart
    └── wsk.dart
</pre>

#### `wsk/assets` directory 

`wsk/assets` directory includes precompiled static resources which might be referenced by web pages. In Dart project, this directory can be referenced as `packages/ask/assets` from your HTML document. you can change the path on release build by adding `transformers` section inside `pubspec.yaml`.

You can include the Web Starter Kit's stylesheets once you have added this package as a 
dependency to your application:

```html
    <!-- include the stylesheets -->
    <link rel="stylesheet" href="packages/wsk/assets/styles/main.css">
    
```

#### `wsk/sass` directory 

`wsk/sass` directory includes source files for `wsk/assets/styles/main.css` and `wsk/assets/styles/components/components.css`. You might want to copy this directory to your project directory if you want to modify sass files to opt out some of the style difinitions.

<!--
### NOTE:

* Problem on SaSS transformer importing files from external packages.
  The Transformer in "saas" package has a bug which prevents to import
  scss files from other packages. So, Right now, you better just copy 
  all the scss files from "packages/wsk/scss" to your project directory.
  https://bitbucket.org/evidentsolutions/dart-sass/issue/21/import-file-in-package
-->

#### `wsk/templates` directory 

`wsk/templates` directory includes a web application template for your project. You just copy all the directories inside it to your {project} root directory.

* **index.html** (`index.html`, `index.dart`)  
    Your main web application.
* **styleguide.html** (`styleguide.html`, `styleguide.dart`)  
    A sample web application containing all the HTML snippet for Web Starter Kit.


## Transformer

**wsk** package has a transformer to modify an asset path for release build.
This way asset files can be placed on any servers.

Read [docs/transformer.md](docs/transformer.md) for more detail.


## Change Logs

** 0.5.1 (11/13/2014)**  
* Initial push


## License

**web_starter_kit.dart** (**wsk**) is released under the [Apache 2.0 License](LICENSE) by Hiroshi Yamamoto <higon@freepress.jp>


## Learn more

* [Web Starter Kit](http://developers.google.com/web/starter-kit)  (Beta) on Google Developers
* [Web Starter Kit](https://github.com/google/web-starter-kit) on Github 
