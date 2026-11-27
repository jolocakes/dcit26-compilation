import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/random_user.dart';

/// Fetches a single random user from the Random User Generator API.
///
/// Returns a typed [RandomUser]. Throws on a non-200 response or when the
/// payload has no user data, so callers can surface an error state.
Future<RandomUser> fetchRandomUser() async {
  final response = await http.get(
    Uri.parse('https://randomuser.me/api/'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load user (status ${response.statusCode})');
  }

  final data = jsonDecode(response.body) as Map<String, dynamic>;
  final results = data['results'] as List<dynamic>?;

  if (results == null || results.isEmpty) {
    throw const FormatException('No user data returned');
  }

  return RandomUser.fromJson(results.first as Map<String, dynamic>);
}
