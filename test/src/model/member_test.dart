import 'package:darthatesmoney/src/model/member.dart';
import 'package:test/test.dart';

void main() {
  group('Member', () {
    test('can be instanciated from json', () {
      const json =
          '{"weight": 1, "activated": true, "id": 31, "name": "Arnaud"}';
      final member = Member.fromJson(json);
      expect(member, isNotNull);
      expect(member.id, 31);
    });
    test('can be instanciated with balance from json', () {
      const json =
          // ignore: lines_longer_than_80_chars
          '{"id": 11532, "name": "peter", "weight": 1.0, "activated": true, "balance": 5.0}';
      final member = MemberWithBalance.fromJson(json);
      expect(member, isNotNull);
      expect(member.id, 11532);
    });
  });
}
