// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:meta/meta.dart';

@immutable

/// {@template member}
/// Represents a ihatemoney.org member. Used in member info route.
///
/// See [this documentation link](https://ihatemoney.readthedocs.io/en/latest/api.html#members).
/// {@endtemplate}
class Member {
  /// {@macro member}
  const Member({
    required this.id,
    required this.name,
    required this.weight,
    required this.activated,
  });

  /// A factory constructor used to create a [Member] from a [Map].
  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] as int,
      name: map['name'] as String,
      weight: map['weight'] as num,
      activated: map['activated'] as bool,
    );
  }

  /// A factory constructor used to create a [Member] from a [String] as json.
  factory Member.fromJson(String source) =>
      Member.fromMap(json.decode(source) as Map<String, dynamic>);

  /// This member id.
  final int id;

  /// This member name.
  final String name;

  /// This member weight in the balance.
  final num weight;

  /// Whether this member is activated or not.
  final bool activated;

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'Member(id: $id, name: $name, weight: $weight, activated: $activated)';
  }

  @override
  bool operator ==(covariant Member other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.weight == weight &&
        other.activated == activated;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ weight.hashCode ^ activated.hashCode;
  }
}

/// {@template memberwithbalance}
/// A [Member] with a [balance] field. Mainly used in project info route.
/// {@endtemplate}
final class MemberWithBalance extends Member {
  /// {@macro memberwithbalance}
  const MemberWithBalance({
    required super.id,
    required super.name,
    required super.weight,
    required super.activated,
    required this.balance,
  });

  /// A factory constructor used to create a [Member] from a [Map].
  factory MemberWithBalance.fromMap(Map<String, dynamic> map) {
    return MemberWithBalance(
      id: map['id'] as int,
      name: map['name'] as String,
      weight: map['weight'] as num,
      activated: map['activated'] as bool,
      balance: map['balance'] as num,
    );
  }

  /// A factory constructor used to create a [Member] from a [String] as json.
  factory MemberWithBalance.fromJson(String source) =>
      MemberWithBalance.fromMap(json.decode(source) as Map<String, dynamic>);

  /// The member current balance.
  final num balance;

  @override
  bool operator ==(covariant MemberWithBalance other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.weight == weight &&
        other.activated == activated &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        weight.hashCode ^
        activated.hashCode ^
        balance.hashCode;
  }
}
