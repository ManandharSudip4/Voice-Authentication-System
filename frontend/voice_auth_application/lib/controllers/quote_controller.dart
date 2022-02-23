import 'dart:convert';

import 'package:http/http.dart' as http;


Future<String> getRandomQuote() async{
  final response = await http
    .get(Uri.parse('https://api.quotable.io/random'));
  final json = jsonDecode(response.body);
  final data = json['content'];
  return data;
}