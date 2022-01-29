import 'package:flutter/material.dart';
import 'package:voice_auth_app/imports/datas.dart';

Widget noteCardTemplate(Note note){
  return SizedBox(
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
                  note.date,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xff838996) 
                  ),
                ),
  
              ],
            ),
            const SizedBox(height: 10,),
            Text(
              note.content,
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
  );
}

Widget noteCardTemplateWithSeparation(Note note){
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
    child: noteCardTemplate(note),
  );
}