import 'package:darthatesmoney/src/model/project_info.dart';
import 'package:test/test.dart';

void main() {
  group('Project Info', () {
    test('can be instanciated from json', () {
      const json = '''
{
    "id": "demo",
    "name": "demonstration",
    "contact_email": "demo@notmyidea.org",
    "default_currency": "XXX",
    "members": [
        {
            "id": 11515,
            "name": "f",
            "weight": 1.0,
            "activated": true,
            "balance": 0
        },
        {
            "id": 11531,
            "name": "g",
            "weight": 1.0,
            "activated": true,
            "balance": 0
        },
        {
            "id": 11532,
            "name": "peter",
            "weight": 1.0,
            "activated": true,
            "balance": 5.0
        },
        {
            "id": 11558,
            "name": "Monkey",
            "weight": 1.0,
            "activated": true,
            "balance": 0
        },
        {
            "id": 11559,
            "name": "GG",
            "weight": 1.0,
            "activated": true,
            "balance": -5.0
        }
    ]
}''';
      final projectInfo = ProjectInfo.fromJson(json);
      expect(projectInfo, isNotNull);
      expect(projectInfo.id, 'demo');
      expect(projectInfo.members.length, 5);
    });
  });
}
