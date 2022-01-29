import 'package:flutter/material.dart';
import 'package:voice_auth_app/imports/ev.dart';
import 'package:voice_auth_app/imports/datas.dart';
import 'package:voice_auth_app/views/templates/note_card.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> with TickerProviderStateMixin{
  final int _noOfNotes = 20;

  final int _noOfImportantNotes = 5;

  final String userName = "User Name";

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
          },
        ),
        body: SafeArea(
          child: Column(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: [
                    userHeader(userName),
                    const SizedBox( height: 20,),
                    noteAndImportantBlock(notes: _noOfNotes, important: _noOfImportantNotes),
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
                    notesList(),
                    importantNotesList()
                  ],
                  controller: _tabController,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

Widget userHeader(String name){
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



Widget notesList(){
  return ListView(
    children: notesData.map((note) => noteCardTemplateWithSeparation(note)).toList(),
  );
}

Widget importantNotesList(){
  return ListView(
    children: importantNotesData.map((note) => noteCardTemplateWithSeparation(note)).toList(),
  );
}