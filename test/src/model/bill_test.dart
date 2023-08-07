import 'package:darthatesmoney/src/model/bill.dart';
import 'package:test/test.dart';

void main() {
  group('Bill', () {
    test('can be instanciated from json', () {
      const json = '''
{
  "id": 42,
  "payer_id": 11,
  "owers": [
    {
      "id": 22,
      "name": "Alexis",
      "weight": 1,
      "activated": true
    }
  ],
  "amount": 100,
  "date": "2020-12-24",
  "creation_date": "2021-01-13",
  "what": "Raclette du nouvel an",
  "external_link": "",
  "original_currency": "XXX",
  "converted_amount": 100
}''';
      final bill = Bill.fromJson(json);
      expect(bill, isNotNull);
      expect(bill.id, 42);
    });
  });
}
