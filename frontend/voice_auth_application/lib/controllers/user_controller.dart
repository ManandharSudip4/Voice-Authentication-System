import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:voice_auth_app/models/response.dart';
import 'package:voice_auth_app/imports/ev.dart';
Future<ResponseUsers> getAllUsers() async {
  final response = await http
      .get(Uri.parse('$ipAddr/user/users'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
  // print(res.data);
    return ResponseUsers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future register(String userName, String filename) async{
  final Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  String filepath = path + '/' + filename + '.wav';
  final request = http.MultipartRequest('POST', Uri.parse('$ipAddr/user/registerUser'));
  request.fields['userName'] =  userName;
  request.files.add( http.MultipartFile.fromBytes(
    'audioFile', 
    File(filepath).readAsBytesSync(),
    filename: (filename + '.wav').split("/").last
  ));
  // print('\\\\\\\\\\\(..)//////////////////');
  var res = await request.send();
  // print('::::::::::::::::::::::::::::');
  final body = json.decode(await res.stream.bytesToString());
  ResponseUsers response = ResponseUsers.fromJson(body);
  print(res.headers['auth-token']);
}

Future login(String? userName, String? filename) async{
  final Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  String filepath = path + '/' + filename !+ '.wav';
  final request = http.MultipartRequest('POST', Uri.parse('$ipAddr/user/loginUser'));
  request.fields['userName'] =  userName!;
  request.files.add( http.MultipartFile.fromBytes(
    'audioFile', 
    File(filepath).readAsBytesSync(),
    filename: (filename + '.wav').split("/").last
  ));
  // print('\\\\\\\\\\\(..)//////////////////');
  var res = await request.send();
  // print('::::::::::::::::::::::::::::');
  final body = json.decode(await res.stream.bytesToString());
  ResponseUsers response = ResponseUsers.fromJson(body);
  print(response.error);
}