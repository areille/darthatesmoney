import 'dart:convert';

import 'package:darthatesmoney/src/model/bill.dart';
import 'package:darthatesmoney/src/model/member.dart';
import 'package:darthatesmoney/src/model/project_info.dart';
import 'package:darthatesmoney/src/model/statistics.dart';
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

  /// The authentication header
  MapEntry<String, String> get authHeader => MapEntry(
        'authorization',
        'Basic ${base64.encode(utf8.encode('$projectName:$privateCode'))}',
      );

  // ========
  // PROJECTS
  // ========

  /// Returns basic project info.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#getting-information-about-the-project)
  Future<ProjectInfo> getProjectInfo() async {
    final response = await http.get(
      projectUri,
      headers: {
        authHeader.key: authHeader.value,
      },
    );

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
    final response = await http.get(
      Uri.parse('$projectUri/members'),
      headers: {
        authHeader.key: authHeader.value,
      },
    );

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
    final response = await http.get(
      Uri.parse('$projectUri/bills'),
      headers: {
        authHeader.key: authHeader.value,
      },
    );

    return (json.decode(response.body) as List<dynamic>)
        .map((x) => Bill.fromMap(x as Map<String, dynamic>))
        .toList();
  }

  /// Fetch a bill.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#bills)
  Future<Bill> getBill(String id) async {
    final response = await http.get(
      Uri.parse('$projectUri/bills/$id'),
      headers: {
        authHeader.key: authHeader.value,
      },
    );

    return Bill.fromMap(json.decode(response.body) as Map<String, dynamic>);
  }

  /// Deletes a bill.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#bills)
  Future<void> deleteBill(String id) => http.delete(
        Uri.parse('$projectUri/bills/$id'),
        headers: {
          authHeader.key: authHeader.value,
        },
      );

  // ==========
  // STATISTICS
  // ==========

  /// Lists a project stats.
  ///
  /// [Docs](https://ihatemoney.readthedocs.io/en/latest/api.html#statistics)
  Future<List<Statistics>> listStatistics() async {
    final response = await http.get(
      Uri.parse('$projectUri/statistics'),
      headers: {
        authHeader.key: authHeader.value,
      },
    );

    return (json.decode(response.body) as List<dynamic>)
        .map((x) => Statistics.fromMap(x as Map<String, dynamic>))
        .toList();
  }
}
