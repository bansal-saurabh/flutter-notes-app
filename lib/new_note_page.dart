import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/note.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({Key key}) : super(key: key);

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  String noteTitle = 'Untitled';

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Notes'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TextField(
                  controller: description,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 65),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: FloatingActionButton(
              heroTag: 'Save',
              backgroundColor: Colors.green,
              child: Icon(Icons.save, color: Colors.white),
              tooltip: 'Save Note',
              onPressed: () {
                if (description.text.isNotEmpty) {
                  if (title.text.isNotEmpty) {
                    noteTitle = title.text;
                  }
                  var note = Note()
                    ..title = noteTitle
                    ..description = description.text
                    ..created = DateTime.now();
                  Hive.box<Note>('notes').add(note);
                  Fluttertoast.showToast(
                    msg: "Note saved!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Note discarded!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                  );
                }
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            child: FloatingActionButton(
              heroTag: 'Discard',
              backgroundColor: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              tooltip: 'Discard Note',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
