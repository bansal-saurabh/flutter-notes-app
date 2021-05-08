import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/note.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({Key key}) : super(key: key);

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
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
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TextField(
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
              backgroundColor: Colors.green,
              child: Icon(Icons.save, color: Colors.white),
              tooltip: 'Save Note',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(Icons.save, color: Colors.white),
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
