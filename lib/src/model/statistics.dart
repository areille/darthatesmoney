import 'dart:convert';

import 'package:darthatesmoney/src/model/member.dart';
import 'package:meta/meta.dart';

@immutable

/// {@template stats}
/// Represents a ihatemoney.org statistics.
///
/// See [this documentation link](https://ihatemoney.readthedocs.io/en/latest/api.html#statistics).
/// {@endtemplate}
class Statistics {
  /// {@macro stats}
  const Statistics({
    required this.member,
    required this.paid,
    required this.spent,
    required this.balance,
  });

  /// A factory constructor used to create a [Statistics] from a [Map].
  factory Statistics.fromMap(Map<String, dynamic> map) {
    return Statistics(
      member: Member.fromMap(map['member'] as Map<String, dynamic>),
      paid: map['paid'] as num,
      spent: map['spent'] as num,
      balance: map['balance'] as num,
    );
  }

  /// A factory constructor used to create a [Statistics] from a [String] as
  /// json.
  factory Statistics.fromJson(String source) =>
      Statistics.fromMap(json.decode(source) as Map<String, dynamic>);

  /// This stats member.
  final Member member;

  /// This member paid amount.
  final num paid;

  /// This member spent amount.
  final num spent;

  /// This member balance.
  final num balance;

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'Statistics(member: $member, paid: $paid, spent: $spent, balance: $balance)';
  }

  @override
  bool operator ==(covariant Statistics other) {
    if (identical(this, other)) return true;

    return other.member == member &&
        other.paid == paid &&
        other.spent == spent &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return member.hashCode ^ paid.hashCode ^ spent.hashCode ^ balance.hashCode;
  }
}
