library routing_utils;

import 'dart:html';
import 'package:route_hierarchical/client.dart';


/// Creates a new Router with the given URL-to-ElementId mapping.
///
/// Dart Code:
///
///     Map<String, String> url_to_id_map = {
///         "/welcome": "#welcome",
///         "/home": "#home",
///         "/about": "#about",
///     };
///     newRouter(url_to_id_map).listen();
///
/// Corresponding HTML (Menu):
///
///     <ul>
///       <li><a href="#/welcome">Welcome</a></li>
///       <li><a href="#/home">Home</a></li>
///       <li><a href="#/about">About</a></li>
///       <li><a href="http://www.google.com/" target="_self">External link</a></li>
///     </ul>
///
/// Corresponding HTML (Contents):
///
///     <div id="welcome">
///         Welcome Content
///     </div>
///     <div id="home" style="display:none;">
///         Home Content
///     </div>
///     <div id="about" style="display:none;">
///         Home Content
///     </div>
Router newRouter([Map<String, String> url_to_elementId_map]) {
  final switchContent = newSwitchContentHandler(url_to_elementId_map);
  final router = new Router(useFragment: true); // With URL hashes.
  if (url_to_elementId_map != null) url_to_elementId_map.forEach((k, v) => router.root.addRoute(name: k, path: k, enter: switchContent));
  return router;
}

/// Changes visibility of the element or children of the element.
void changeElementVisibility(String name, bool visible, [bool targetChildren = false]) {
  Element elem = querySelector(name);
  if (elem == null) return;

  final switchVisibleFunc = (Element e) => e.style.display = visible ? '' : 'none';
  if (targetChildren) elem.children.forEach(switchVisibleFunc); else switchVisibleFunc(elem);
}

/// Switches content by changing visibility of elements registered in the given map.
bool switchContentByUrl(Map<String, String> url_to_id_map, String url) {
  final hasURL = url_to_id_map.containsKey(url);
  if (hasURL) url_to_id_map.forEach((k, v) => changeElementVisibility(v, k == url));
  return hasURL;
}

/// Creates new [RouteEnterEventHandler] which reveals a content by changing visibility of all the other contents.
RouteEnterEventHandler newSwitchContentHandler(Map<String, String> url_to_id_map, [url]) {
  return (RouteEvent e) {
    switchContentByUrl(url_to_id_map, url != null ? url : e.path);
  };
}
