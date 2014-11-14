import 'package:wsk/wsk.dart';
import 'package:wsk/routing_utils.dart';

/// Application Main
void main() {

  // Listeners
  initWebStarterKit();

  // Routing
  var url_to_id_map = {
    "/welcome": "#welcome", // {URL}, {HTML tag id}
    "/home": "#home",
    "/about": "#about",
  };
  newRouter(url_to_id_map).listen();

}
