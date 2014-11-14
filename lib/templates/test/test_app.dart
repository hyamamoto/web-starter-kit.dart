library test_app;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

// Run 'test_xxx.html' by "Run in Dartium" option.
// Test results will be displayed in the Dartium window,
// and exit codes are shown in the editor’s Debugger tab.

main() {

  useHtmlConfiguration();

  setUp(() {});
  tearDown(() {});

  group('test_group_1', () {
    test('XXX Test', () { //
//      expect(xxx, true);
//      expect(xxx, false);
    });
    test('YYY Test', () { //
//      expect(yyy, true);
//      expect(yyy, false);
    });
  });
}
