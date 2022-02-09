import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_auth_app/imports/loading.dart';
import 'package:voice_auth_app/views/notes.dart';
import 'package:voice_auth_app/views/users.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({ Key? key }) : super(key: key);

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  // bool islogin = false;

  @override
  void initState(){
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async{
    //   islogin = await isLogin();
    // });
    // isLogin().then((data) {
    //   islogin = data;
    // });
    // print(islogin);
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<bool>(
      future: isLogin(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          bool islogin = snapshot.data ?? false;
          // print(islogin);
          return islogin ? const NotesView() : const UsersView();
        }else{
          return Loading();
        }
      },
    );
  }
}

Future<bool> isLogin() async{
  bool isLogin = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('auth-token') ?? "";
  // print(token);
  if (token != ""){
    isLogin = true;
  }
  return isLogin;
}
