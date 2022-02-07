import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_auth_app/config.dart';
import 'package:voice_auth_app/models/note.dart';
import 'package:voice_auth_app/models/response_note.dart';

Future<Map<String, String>> getheader() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('auth-token') ?? "";
  final Map<String, String> header = {
    "Content-type": "application/json",
    'auth-token': token
  };
  return header;
}

String getbody(Note note){
  final Map<String, dynamic> data = {
    'title': note.title,
    'body': note.body,
    'important': note.important
  };
  String body = json.encode(data);
  return body;
} 

Future createNotes(Note note) async {
  Map<String, String> header = await getheader();
  String body = getbody(note);
  await http
    .post(Uri.parse("$ipAddr/user/notes/create"), headers: header, body: body);
}

Future<ResponseNotes> getNotes() async {
  Map<String, String> header = await getheader();
  final response = await http
    .get(Uri.parse("$ipAddr/user/notes"), headers: header);
  ResponseNotes res = ResponseNotes.fromJson(jsonDecode(response.body));
  return res;
}

Future updateNote(Note note) async{
  Map<String, String> header = await getheader();
  String body = getbody(note);
  await http
    .put(Uri.parse("$ipAddr/user/notes/${note.id}"), headers: header, body: body);
}

Future deleteNote(String? id) async{
  Map<String, String> header = await getheader();
  await http
    .delete(Uri.parse('$ipAddr/user/notes/$id'), headers: header);
}