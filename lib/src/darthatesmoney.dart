import 'dart:convert';

import 'package:darthatesmoney/src/model/member.dart';
import 'package:darthatesmoney/src/model/project_info.dart';
import 'package:http/http.dart' as http;

/// {@template darthatesmoney}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class Darthatesmoney {
  /// {@macro darthatesmoney}
  const Darthatesmoney({
    required this.projectName,
    required this.privateCode,
  });

  /// The ihatemoney.org project name.
  final String projectName;

  /// The ihatemoney.org private code.
  final String privateCode;

  /// This ihatemoney.org uri.
  Uri get projectUri =>
      Uri.parse('https://ihatemoney.org/api/projects/$projectName');

  /// The ihatemoney.org uri, containing the HTTP Basic info for auth.
  Uri authenticatedUri(Uri uri) =>
      uri.replace(userInfo: '$projectName:$privateCode');

  /// Returns basic project info.
  Future<ProjectInfo> getProjectInfo() async {
    final response = await http.get(authenticatedUri(projectUri));

    return ProjectInfo.fromJson(response.body);
  }

  /// Lists a project members. See [this link](https://ihatemoney.readthedocs.io/en/latest/api.html#members)
  Future<Set<Member>> listMembers() async {
    final response =
        await http.get(authenticatedUri(Uri.parse('$projectUri/members')));

    return (json.decode(response.body) as List<dynamic>)
        .map((x) => Member.fromMap(x as Map<String, dynamic>))
        .toSet();
  }
}
