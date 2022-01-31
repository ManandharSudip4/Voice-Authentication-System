import 'package:flutter/material.dart';
import 'package:voice_auth_app/checklogin.dart';
import 'package:voice_auth_app/imports/ev.dart';
import 'package:voice_auth_app/imports/loading.dart';
import 'package:voice_auth_app/models/response_note.dart';
import 'package:voice_auth_app/models/response_user.dart';
import 'package:voice_auth_app/models/note.dart';
import 'package:voice_auth_app/views/create_notes.dart';
import 'package:voice_auth_app/views/templates/note_card.dart';
import 'package:voice_auth_app/controllers/user_controller.dart' as user_controller;
import 'package:voice_auth_app/controllers/note_controller.dart' as note_controller;
import 'package:voice_auth_app/views/users.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget notesList(List<Note> notes){
      return ListView(
        children: notes.map((note) => noteCardTemplateWithSeparation(note, context)).toList(),
      );
    }

    Widget importantNotesList(List<Note> importantNotes){
      return ListView(
        children: importantNotes.map((note) => noteCardTemplateWithSeparation(note, context)).toList(),
      );
    }
    return FutureBuilder<ResponseSingleUser>(
      future: user_controller.getUserInfo(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          ResponseSingleUser? data = snapshot.data;
          String? userName = data?.data?.userName;
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: backgroundColor,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                backgroundColor: Colors.green,
                onPressed: () async{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateNotes())
                  );
                },
              ),
              body: SafeArea(
                child: FutureBuilder<ResponseNotes>(
                  future: note_controller.getNotes(),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      ResponseNotes? res = snapshot.data;
                      List<Note>? notes = res?.data;
                      List<Note> importantNotes = [];
                      notes?.forEach((note) { 
                        if (note.important == true) importantNotes.add(note);
                      });
                      return Column(
                        children:<Widget> [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: Column(
                              children: [
                                userHeader(userName ?? "" , context),
                                const SizedBox( height: 20,),
                                noteAndImportantBlock(notes: notes!.length, important: importantNotes.length),
                                const SizedBox(height: 30,),
                                ///// NavBar ///////
                                TabBar(
                                  unselectedLabelColor: const Color(0xff848482),
                                  labelColor: const Color(0xffffffff),
                                  labelStyle: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  tabs: const <Widget>[
                                    Tab(
                                      text: 'Notes',
                                    ),
                                    Tab(
                                      text: 'Important',
                                    )
                                  ],
                                  controller: _tabController,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                notesList(notes),
                                importantNotesList(importantNotes)
                              ],
                              controller: _tabController,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Loading();
                    }
                  }
                ),
              ),
            )
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

Widget userHeader(String name, BuildContext context){
  return Row(
    children:  <Widget>[
      const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 30,
      ),
      const SizedBox( width: 20,),
      Text(
        name,
        style: const TextStyle(
          fontSize: 30,
          color: Color(0xffffffff)
        ),
      ),
      const SizedBox( width: 110,),
      TextButton(
        onPressed: (){
          user_controller.logout();
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (context) => const UsersView()), 
            (route) => false
          );
        }, 
        child: const Icon(
          Icons.logout,
          color: Color(0xffffffff),
        )
      )
    ],
  );
}

Widget noteAndImportantBlock({int notes = 0, int important = 0}){
  return Row (
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget> [
      Container(
        width: 140,
        height: 160,
        decoration: BoxDecoration(
          color: const Color(0xff1569C7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 5, 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Notes",
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xffffffff)
                ),
              ),
              Text(
                "$notes",
                style: const TextStyle(
                  fontSize: 40,
                  color: Color(0xffffffff)
                ),
              )
            ],
          ),
        ),
      ),
      Container(
        width: 140,
        height: 160,
        decoration: BoxDecoration(
          color: const Color(0xffE5E4E5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 5, 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Important",
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xff000000)
                ),
              ),
              Text(
                "$important",
                style:const  TextStyle(
                  fontSize: 40,
                  color: Color(0xff000000)
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}
