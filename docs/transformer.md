# Web Starter Kit for Dart 

 ( **wsk** in pub repository )

## Transformer 

`wsk` package has a transformer which can modify an asset path in all the HTML files on release build.

```html
    <!-- include the stylesheets -->
    <link rel="stylesheet" href="packages/wsk/assets/styles/main.css">
    
```

Note that the versions in the snippets above are the non-minified version. The transformer available
in this package will automatically rewrite the URI to point to the minified versions when pub is 
invoked in release mode.

To activate the transformer, update your `pubspec.yaml`

The transformer will automatically rewrite the URI to point to the minified 
versions when pub is invoked in release mode.

To activate the transformer, update your pubsepc.yaml:

```yaml
transformers:
- wsk:
    url: //cache.frontend.com/wsk/{{version}}
    version: 1.0.0
```

The transformer takes up to two optional parameters:
* url: 
when specified the local base url (packages/wsk/) will be replaced by the given url. 
* version: 
when specified, the sub-string "{{version}}" in the url parameter will be replaced with its value.

The transformer takes up to two optional parameters:
- `url`: when specified the local base url to assets directory (`packages/wsk/assets`) will be replaced by the
  given url. This is useful to automatically switch to using a CDN for your production environment.
- `version`: when specified, the sub-string "{{version}}" in the `url` parameter will be replaced 
   with its value.
