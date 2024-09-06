import 'package:database_application/domain/dbhelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper dbHelper = DBHelper.getinstance();

  List<Map<String, dynamic>> allNotes = [];
  @override
  void initState() {
    super.initState();
    getMyNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      body: ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
              subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool check = await dbHelper.addNote(
              title: "My nNote",
              desc: "Do what u love and Love what u do !!!!");

          if (check) {
            getMyNotes();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void getMyNotes() async {
    allNotes = await dbHelper.getAllNotes();
    setState(() {});
  }
}
