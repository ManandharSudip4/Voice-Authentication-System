import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:voice_auth_app/imports/ev.dart';
import 'package:voice_auth_app/models/response_user.dart';
import 'package:voice_auth_app/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ResponseSingleUser> getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('auth-token') ?? "";
  final Map<String, String> header = {'auth-token': token};
  final response = await http.get(Uri.parse('$ipAddr/user'), headers: header);
  // print(response.body);
  return ResponseSingleUser.fromJson(jsonDecode(response.body));
}

Future<ResponseUsers> getAllUsers() async {
  final response = await http.get(Uri.parse('$ipAddr/user/users'));

  return ResponseUsers.fromJson(jsonDecode(response.body));
  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.
  // // print(res.data);
  //   return ResponseUsers.fromJson(jsonDecode(response.body));
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load album');
  // }
}

Future register(String userName, String filename) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  String filepath = path + '/' + filename + '.wav';
  final request =
      http.MultipartRequest('POST', Uri.parse('$ipAddr/user/registerUser'));
  request.fields['userName'] = userName;
  request.fields['sentence'] = registerSentence;
  request.files.add(http.MultipartFile.fromBytes(
      'audioFile', File(filepath).readAsBytesSync(),
      filename: (filename + '.wav').split("/").last));
  // print('\\\\\\\\\\\(..)//////////////////');
  var res = await request.send();
  // print('::::::::::::::::::::::::::::');
  final body = json.decode(await res.stream.bytesToString());
  ResponseUsers response = ResponseUsers.fromJson(body);
  // print(res.headers['auth-token']);
  if (response.status == "OK") {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth-token', res.headers['auth-token'] ?? "");
  }
}

Future<ResponseUsers> login(
    String? userName, String? filename, String? sentence) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  String filepath = path + '/' + filename! + '.wav';
  final request =
      http.MultipartRequest('POST', Uri.parse('$ipAddr/user/loginUser'));
  request.fields['userName'] = userName!;
  request.fields['sentence'] = sentence!;
  request.files.add(http.MultipartFile.fromBytes(
      'audioFile', File(filepath).readAsBytesSync(),
      filename: (filename + '.wav').split("/").last));
  // print('\\\\\\\\\\\(..)//////////////////');
  var res = await request.send();
  // print('::::::::::::::::::::::::::::');
  final body = json.decode(await res.stream.bytesToString());
  ResponseUsers response = ResponseUsers.fromJson(body);
  if (response.status == "OK") {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth-token', res.headers['auth-token'] ?? "");
  }
  return response;
}

Future logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("auth-token", "");
  // await prefs.remove('auth-token');
}
