import 'package:flutter/material.dart';
import 'package:voice_auth_app/controllers/user_controller.dart' as user_controller;
import 'package:voice_auth_app/models/user.dart';
import 'package:voice_auth_app/imports/ev.dart';
import 'package:voice_auth_app/imports/loading.dart';
import 'package:voice_auth_app/models/response.dart';
import 'package:voice_auth_app/views/auth/login.dart';
import 'package:voice_auth_app/views/auth/register.dart';

class UsersView extends StatelessWidget {
  const UsersView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResponseUsers>(
      future: user_controller.getAllUsers(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          ResponseUsers? response = snapshot.data;
          return Scaffold(
            backgroundColor: backgroundColor,
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisrationView()),
                );
              },
              child: const Icon(Icons.add),
              backgroundColor: floatingButtonColor,
            ),
            body:  SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 20, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  <Widget>[
                  const Text(
                      "   Users",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xffffffff)
                      ),
                    ),
                    const SizedBox(height: 40,),
                    Expanded(
                      child: ListView(
                        children: response!.data!.map((user) => userCardWithSeparation(context, user)).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  Widget userCardWithSeparation(context, User user){
    return Column(
      children: <Widget>[
        userCard(context, user),
        const SizedBox(height: 10,)
      ],
    );
  }

  Widget userCard(context,User user){
    return InkWell(
      onTap: (){
        String id = user.id;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  LoginView(id: user.id, uname: user.userName,)),
        );
        print(user.userName);
        print(user.id);
      },
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 25),
          child: Row(
           children: <Widget>[
              const CircleAvatar(
                backgroundColor: Colors.red,
              ),
              const SizedBox(width: 20,),
              SizedBox(
                width: 200,
                child: Text(
                  user.userName,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}