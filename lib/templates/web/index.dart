import 'package:wsk/wsk.dart';
import 'package:wsk/routing_utils.dart';

/// Application's main method.
void main() {

  //
  // Menu Listeners
  //
  initWebStarterKit();

  //
  // Routing
  //

  // A URL-to-ElementID table
  Map<String, String> url_to_id_map = {
    "/welcome": "#welcome",
    "/home": "#home",
    "/about": "#about",
  };
  newRouter(url_to_id_map).listen();

  // Hide everything but #welcome.
  // switchContentByUrl(url_to_id_map, "/welcome");
}

