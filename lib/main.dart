import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_notes_app/note.dart';
import 'package:flutter_notes_app/notes_list.dart';
import 'package:flutter_notes_app/new_note_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  await Hive.openBox<Note>('notes');
  await Hive.openBox('settings');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        fontFamily: 'OpenSans',
      ),
      home: NoteMainScreen(),
    );
  }
}

class NoteMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Notes'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: _buildWithBox,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'New Note',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewNotePage()));
        },
      ),
    );
  }

  Widget _buildWithBox(BuildContext context, Box settings, Widget child) {
    var reversed = settings.get('reversed', defaultValue: true) as bool;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Notes',
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 40),
        Expanded(
          child: ValueListenableBuilder<Box<Note>>(
            valueListenable: Hive.box<Note>('notes').listenable(),
            builder: (context, box, _) {
              var notes = box.values.toList().cast<Note>();
              if (reversed) {
                notes = notes.reversed.toList();
              }
              return NoteList(notes);
            },
          ),
        ),
      ],
    );
  }
}
