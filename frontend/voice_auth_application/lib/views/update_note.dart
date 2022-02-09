import 'package:flutter/material.dart';
import 'package:voice_auth_app/models/note.dart';
import 'package:voice_auth_app/imports/ev.dart';
import 'package:voice_auth_app/controllers/note_controller.dart' as note_controller;
import 'package:voice_auth_app/views/notes.dart';

class UpdateNote extends StatefulWidget {
  const UpdateNote({ Key? key , this.id, this.title, this.body, this.favorite}) : super(key: key);
  
  final String? id;
  final String? title;
  final String? body;
  final bool? favorite;
  
  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool favorite = false; 
  String title = "";
  String body = "";
  bool getfavorite = true;
  @override
  Widget build(BuildContext context) {
    getfavorite ?  favorite =  widget.favorite ?? false : null;
    title = widget.title ?? "";
    body = widget.body ?? "";
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
                getfavorite = false;
              });
            }, 
            child: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xffffffff),
            )
          ),
          TextButton(
            onPressed: () async {
              await note_controller.deleteNote(widget.id);
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => const NotesView()),
                (route) => false
              );
            }, 
            child: const Icon(
              Icons.delete,
              color: Color(0xffffffff)
            )
          ),
          TextButton(
            onPressed: () async {
              Note note = Note(id: widget.id, title: title, body:body, important: favorite);
              await note_controller.updateNote(note);
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => const NotesView()), 
                (route) => false
              );
            }, 
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
                  initialValue: widget.title,
                  decoration: noteTitleDecoration,
                  style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 35
                  ),
                  onChanged: (val) => title = val,
                ),
                TextFormField(
                  initialValue: widget.body,
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