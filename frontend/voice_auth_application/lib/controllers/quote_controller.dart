import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getRandomQuote() async {
  String data = '';
  const minLength = 100;
  const maxLength = 150;
  final response = await http.get(Uri.parse(
      'https://api.quotable.io/random?minLength=$minLength&maxLength=$maxLength'));
  final json = jsonDecode(response.body);
  data = json['content'];
  return data;
}
