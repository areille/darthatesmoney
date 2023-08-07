import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:darthatesmoney/src/model/member.dart';
import 'package:meta/meta.dart';

@immutable

/// {@template projectinfo}
/// Represents a ihatemoney.org project info, from [this definition](https://ihatemoney.readthedocs.io/en/latest/api.html#getting-information-about-the-project).
///
/// See [MemberWithBalance].
/// {@endtemplate}
final class ProjectInfo {
  /// {@macro projectinfo}
  const ProjectInfo({
    required this.id,
    required this.name,
    required this.contactEmail,
    required this.defaultCurrency,
    required this.members,
  });

  /// A factory constructor used to create a [ProjectInfo] from a [Map].
  factory ProjectInfo.fromMap(Map<String, dynamic> map) {
    return ProjectInfo(
      id: map['id'] as String,
      name: map['name'] as String,
      contactEmail: map['contact_email'] as String,
      defaultCurrency: map['default_currency'] as String,
      members: Set<MemberWithBalance>.from(
        (map['members'] as List<dynamic>).map<MemberWithBalance>(
          (x) => MemberWithBalance.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// A factory constructor used to create a [ProjectInfo] from a [String] as json.
  factory ProjectInfo.fromJson(String source) =>
      ProjectInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  /// This project id.
  final String id;

  /// This project name.
  final String name;

  /// This project contact email.
  final String contactEmail;

  /// This project default currency.
  final String defaultCurrency;

  /// This project list of members.
  final Set<MemberWithBalance> members;

  @override
  String toString() {
    return 'ProjectInfo(id: $id, name: $name, contactEmail: $contactEmail, defaultCurrency: $defaultCurrency, members: $members)';
  }

  @override
  bool operator ==(covariant ProjectInfo other) {
    if (identical(this, other)) return true;
    final setEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.contactEmail == contactEmail &&
        other.defaultCurrency == defaultCurrency &&
        setEquals(other.members, members);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        contactEmail.hashCode ^
        defaultCurrency.hashCode ^
        members.hashCode;
  }
}
