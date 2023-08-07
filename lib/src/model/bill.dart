import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:darthatesmoney/src/model/member.dart';
import 'package:meta/meta.dart';

@immutable

/// {@template bill}
/// Represents a ihatemoney.org bill, from [this definition](https://ihatemoney.readthedocs.io/en/latest/api.html#bills).
///
/// See [Member].
/// {@endtemplate}
class Bill {
  /// {@macro bill}
  const Bill({
    required this.id,
    required this.payerId,
    required this.owers,
    required this.amount,
    required this.date,
    required this.creationDate,
    required this.what,
    required this.externalLink,
    required this.originalCurrency,
    required this.convertedAmount,
  });

  /// A factory constructor used to create a [Bill] from a [Map].
  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as int,
      payerId: map['payer_id'] as int,
      owers: Set<Member>.from(
        (map['owers'] as List<dynamic>).map<Member>(
          (x) => Member.fromMap(x as Map<String, dynamic>),
        ),
      ),
      amount: map['amount'] as num,
      date: DateTime.parse(map['date'] as String),
      creationDate: DateTime.parse(map['creation_date'] as String),
      what: map['what'] as String,
      externalLink: map['external_link'] as String,
      originalCurrency: map['original_currency'] as String,
      convertedAmount: map['converted_amount'] as num,
    );
  }

  /// A factory constructor used to create a [Bill] from a [String] as json.
  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);

  /// This bill id.
  final int id;

  /// This bill payer id.
  final int payerId;

  /// This bill owers.
  final Set<Member> owers;

  /// This bill amount.
  final num amount;

  /// This bill date.
  final DateTime date;

  /// The date when this bill has been recorded.
  final DateTime creationDate;

  /// This bill title.
  final String what;

  /// This bill external link.
  final String externalLink;

  /// This bill original currency.
  final String originalCurrency;

  /// This bill amount, converted.
  final num convertedAmount;

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'Bill(id: $id, payerId: $payerId, owers: $owers, amount: $amount, date: $date, creationDate: $creationDate, what: $what, externalLink: $externalLink, originalCurrency: $originalCurrency, convertedAmount: $convertedAmount)';
  }

  @override
  bool operator ==(covariant Bill other) {
    if (identical(this, other)) return true;
    final setEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.payerId == payerId &&
        setEquals(other.owers, owers) &&
        other.amount == amount &&
        other.date == date &&
        other.creationDate == creationDate &&
        other.what == what &&
        other.externalLink == externalLink &&
        other.originalCurrency == originalCurrency &&
        other.convertedAmount == convertedAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        payerId.hashCode ^
        owers.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        creationDate.hashCode ^
        what.hashCode ^
        externalLink.hashCode ^
        originalCurrency.hashCode ^
        convertedAmount.hashCode;
  }
}
