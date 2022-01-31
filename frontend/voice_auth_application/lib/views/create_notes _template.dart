import 'package:flutter/material.dart';
import 'package:voice_auth_app/imports/ev.dart';

class CreateNotes extends StatefulWidget {
  const CreateNotes
({ Key? key }) : super(key: key);

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool favorite = false;
  String? title;
  String? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: <Widget>[
          TextButton(
            onPressed: (){
              setState(() {
                favorite = !favorite;
              });
            }, 
            child: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xffffffff),
            )
          ),
          TextButton(
            onPressed: (){}, 
            child: const Icon(
              Icons.save,
              color: Color(0xffffffff),
            )
          ),
          const SizedBox(width: 20,)
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: noteTitleDecoration,
                  style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 35
                  ),
                  onChanged: (val) => title = val,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: noteBodyDecoration,
                  style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 25
                  ),
                  onChanged: (val) => body = val,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}