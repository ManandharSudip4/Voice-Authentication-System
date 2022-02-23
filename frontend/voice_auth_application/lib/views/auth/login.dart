import 'package:flutter/material.dart';
import 'package:voice_auth_app/controllers/user_controller.dart'
    as user_controller;
import 'package:voice_auth_app/controllers/quote_controller.dart'
    as quote_controller;
import 'package:voice_auth_app/imports/ev.dart';
import 'package:voice_auth_app/imports/loading.dart';
import 'package:voice_auth_app/models/response_user.dart';
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
  String? error;
  bool isRecording = false;
  Recorder recorder = Recorder();
  bool doneRecording = false;
  bool postRequest = false;
  bool gotQuote = false;
  String sentence = "";
  bool imposter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: postRequest ? Loading() : login(),
        ),
      ),
    );
  }

  Widget login() {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 100,
                child:
                    Visibility(visible: isRecording, child: MusicVisualizer())),
            const SizedBox(
              height: 20,
            ),
            Text(
              (error != null) ? '$error' : '',
              style: const TextStyle(color: Colors.red, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: FutureBuilder<String>(
                future: quote_controller.getRandomQuote(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    gotQuote ? null : sentence = snapshot.data ?? "";
                    gotQuote = true;
                    return Center(
                      child: Text(
                        sentence,
                        style: const TextStyle(
                            fontSize: 20, color: Color(0xffffffff)),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return LoadingNotFullScreen();
                  }
                },
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 25,
                      )),
                  Visibility(
                    visible: doneRecording,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: elevatedButtonColor,
                            minimumSize: const Size(40, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          setState(() {
                            postRequest = true;
                          });
                          ResponseUsers res = await user_controller.login(
                              widget.uname, widget.uname, sentence);
                          if (res.status == "OK") {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NotesView()),
                                (route) => false);
                          } else {
                            setState(() {
                              error = res.error;
                              postRequest = false;
                              doneRecording = false;
                              gotQuote = false;
                            });
                          }
                        },
                        child: const Text("Done")),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: elevatedButtonColor,
                      minimumSize: const Size(double.infinity, 45)),
                  onPressed: () async {
                    if (!isRecording) {
                      await recorder.init(widget.uname! + ".wav");
                      await recorder.startRecord();
                    } else {
                      await recorder.stopRecord();
                    }
                    setState(() {
                      error = null;
                      isRecording = !isRecording;
                      doneRecording = false;
                      if (!isRecording) doneRecording = true;
                    });
                  },
                  child: Text(isRecording ? 'Stop speaking' : 'Start speaking'))
            ],
          ),
        )
      ],
    );
  }
}
