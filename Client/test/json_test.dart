
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

main()
{

  test("test", (){ var jsonString = '''
  [
    {"perro": 40}, 
    {"score": 90}
  ]
''';

var scores = jsonDecode(jsonString) as Map;
expect(scores is List, true);

var firstScore = scores[0];
expect(firstScore is Map, true);
expect(firstScore['score'] == 40, true);}) ;
 
}  