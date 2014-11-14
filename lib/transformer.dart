library wsk;

import 'package:html5lib/parser.dart' show parse;
import 'package:html5lib/dom.dart' show Document;
import 'package:barback/barback.dart' show Asset, Transform, Transformer, BarbackSettings, BarbackMode;
import 'dart:async' show Future;

/// A [Transformer] for Web Starter Kit for Dart (wsk).
///
/// The transformer will automatically rewrite the URI to point to the minified
/// versions when pub is invoked in release mode.
///
/// To activate the transformer, update your pubsepc.yaml:
///
///     transformers:
///     - wsk:
///         url: //cache.frontend.com/wsk/{{version}}
///         version: 1.0.0
///
/// The transformer takes up to two optional parameters:
/// * url:
///     - when specified the local base url (packages/wsk/assets) will be replaced by the given url.
/// * version:
///     - when specified, the sub-string "{{version}}" in the url parameter will be replaced with its value.
class WskUrlTransformer extends Transformer {
  static const String _BASE_URL = 'packages/wsk/assets';

  bool releaseMode;
  String param_url;

  String get allowedExtensions => '.html';

  WskUrlTransformer.asPlugin(BarbackSettings settings) {
    releaseMode = settings.mode == BarbackMode.RELEASE;
    param_url = settings.configuration['url'];
    var param_version = settings.configuration['param_version'];
    if (param_url != null) {
      if (param_url.contains('{{version}}') && param_version != null) {
        param_url = param_url.replaceAll('{{version}}', '$param_version');
      }
      if (!param_url.endsWith('/')) param_url += '/';
    }
  }

  Future apply(Transform transform) {
    if (releaseMode) {
      print("[wsk] Applying a transformer (Release build)");
      var id = transform.primaryInput.id;

      return transform.primaryInput.readAsString().then((html) => transform.addOutput(new Asset.fromString(id, _rewriteHtml(html))));
    } else {
      print("[wsk] Skipping a transformer (Non-Release build)");
    }
    // Let barback know there is nothing more to do when not in release mode
    return null;
  }

  String _rewriteHtml(String html) {
    Document doc = parse(html);

    doc.querySelectorAll('img[src^="$_BASE_URL"]').forEach((tag) {
      final orgSrc = tag.attributes['src'];
      var src = orgSrc;
      if (param_url != null) {
        src = src.replaceAll(_BASE_URL, param_url);
        print("[wsk] Transformed img/@src [" + orgSrc + "] -> [" + src + "]");
      }
      tag.attributes['src'] = src;
    });

    doc.querySelectorAll('link[href^="$_BASE_URL"]').forEach((tag) {
      final orgHref = tag.attributes['href'];
      var href = orgHref;
      if (!href.endsWith('.min.css')) href = href.replaceAll(new RegExp(r'\.css$'), '.min.css');
      if (param_url != null) {
        href = href.replaceAll(_BASE_URL, param_url);
        print("[wsk] Transformed link@href [" + orgHref + "] -> [" + href + "]");
      }
      tag.attributes['href'] = href;
    });

    return doc.outerHtml;
  }
}
