import 'dart:convert';

import 'package:darthatesmoney/src/model/bill.dart';
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

  static const _baseAPIUrl = 'https://ihatemoney.org/api/';

  /// This ihatemoney.org project uri.
  Uri get projectUri => Uri.parse('${_baseAPIUrl}projects/$projectName');

  /// The ihatemoney.org uri, containing the HTTP Basic info for auth.
  Uri authenticatedUri(Uri uri) =>
      uri.replace(userInfo: '$projectName:$privateCode');

  // ========
  // PROJECTS
  // ========

  /// Returns basic project info.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#getting-information-about-the-project)
  Future<ProjectInfo> getProjectInfo() async {
    final response = await http.get(authenticatedUri(projectUri));

    return ProjectInfo.fromJson(response.body);
  }

  /// Creates a project. Returns the newly created project id.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#creating-a-project)
  Future<String> createProject({
    required String name,
    required String id,
    required String password,
    required String contactEmail,
    String? defaultCurrency,
  }) async {
    final response = await http.post(
      Uri.parse('${_baseAPIUrl}projects'),
      body: {
        'name': name,
        'id': id,
        'password': password,
        'contact_email': contactEmail,
        if (defaultCurrency != null) 'default_currency': defaultCurrency,
      },
    );
    return response.body;
  }

  // ========
  // MEMBERS
  // ========

  /// Lists a project members. See [this link](https://ihatemoney.readthedocs.io/en/latest/api.html#members)
  Future<List<Member>> listMembers() async {
    final response =
        await http.get(authenticatedUri(Uri.parse('$projectUri/members')));

    return (json.decode(response.body) as List<dynamic>)
        .map((x) => Member.fromMap(x as Map<String, dynamic>))
        .toList();
  }

  // ======
  // BILLS
  // ======

  /// Lists a project bills.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#bills)
  Future<List<Bill>> listBills() async {
    final response =
        await http.get(authenticatedUri(Uri.parse('$projectUri/bills')));

    return (json.decode(response.body) as List<dynamic>)
        .map((x) => Bill.fromMap(x as Map<String, dynamic>))
        .toList();
  }

  /// Fetch a bill.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#bills)
  Future<Bill> getBill(String id) async {
    final response =
        await http.get(authenticatedUri(Uri.parse('$projectUri/bills/$id')));

    return Bill.fromMap(json.decode(response.body) as Map<String, dynamic>);
  }

  /// Deletes a bill.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#bills)
  Future<void> deleteBill(String id) =>
      http.delete(authenticatedUri(Uri.parse('$projectUri/bills/$id')));
}
