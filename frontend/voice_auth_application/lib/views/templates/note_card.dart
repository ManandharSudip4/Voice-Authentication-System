import 'package:flutter/material.dart';
import 'package:voice_auth_app/models/note.dart';
import 'package:intl/intl.dart';
import 'package:voice_auth_app/views/update_note.dart';

Widget noteCardTemplate(Note note, BuildContext context){
  return InkWell(
    onTap: (){
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => UpdateNote(id: note.id, title: note.title, body: note.body, favorite: note.important))
      );
    },
    child: SizedBox(
      height: 150,
      child: Card(
        color: const Color(0xffEBF4FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 20, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 160,
                    child: Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('EEE, MMM d').format(note.updatedAt ?? DateTime.now()),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xff838996) 
                    ),
                  ),
    
                ],
              ),
              const SizedBox(height: 10,),
              Text(
                note.body,
                style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xff000000)
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget noteCardTemplateWithSeparation(Note note, BuildContext context){
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
    child: noteCardTemplate(note, context),
  );
}