import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  final int _noOfNotes = 20;
  final int _noOfImportantNotes = 5;
  final String userName = "User Name";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xff3E4768),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child:  Container(
            color: const Color(0xff3E4768),
            child:  SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: <Widget>[
                    userHeader(userName),
                    const SizedBox( height: 20,),
                    noteAndImportantBlock(notes: _noOfNotes, important: _noOfImportantNotes),
                    const SizedBox(height: 30,),
                    const TabBar(
                      tabs: [ Text("Notes"),  Text("Important")],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
              Column(
              children: const <Widget>[ Text("Lunches Page")],
            ),
              Column(
              children: const <Widget>[ Text("Cart Page")],
            )
          ],
        ),
      ),
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
