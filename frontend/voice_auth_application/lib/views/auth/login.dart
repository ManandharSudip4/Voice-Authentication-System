import 'package:flutter/material.dart';
import 'package:voice_auth_app/controllers/user_controller.dart' as user_controller;
import 'package:voice_auth_app/imports/ev.dart';
import 'package:voice_auth_app/utils/recorder.dart';
import 'package:voice_auth_app/views/notes.dart';
import 'package:voice_auth_app/views/templates/music_animation.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key, this.id, this.uname}) : super(key: key);

  final String? id;
  final String? uname;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  
  String error = "";
  bool isRecording = false;
  Recorder recorder = Recorder();
  bool doneRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: login(),
        ),
      ),
    );
  }


  Widget login(){
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            SizedBox(
              height: 100,
              child: Visibility(
                visible: isRecording,
                child: MusicVisualizer()
              )
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                "Test passage to be read by the user to setup the user model",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffffffff)
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: elevatedButtonColor,
                      minimumSize: const Size(40, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                    ),
                    onPressed: (){
                      Navigator.pop(
                        context,
                      );
                    }, 
                    child: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    )
                  ),
                  Visibility(
                    visible: doneRecording,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: elevatedButtonColor,
                        minimumSize: const Size(40, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                      ),
                      onPressed: () async{
                        await user_controller.login(widget.uname, widget.uname);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotesView()),
                        );
                      }, 
                      child: const Icon(
                        Icons.arrow_right_alt_sharp,
                        size: 25,
                      )
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: elevatedButtonColor,
                  minimumSize: const Size(double.infinity, 45)
                ),
                onPressed: () async{
                  if (!isRecording){
                    await recorder.init(widget.uname !+ ".wav");
                    await recorder.startRecord();
                  }else{
                    await recorder.stopRecord();
                  }
                  setState(() {
                    isRecording = !isRecording;
                    doneRecording = false;
                    if (!isRecording) doneRecording = true;
                  });
                }, 
                child:  Text(isRecording ?'Stop speaking' :  'Start speaking')
              )
            ],
          ),
        )
      ],
    );
  }

}