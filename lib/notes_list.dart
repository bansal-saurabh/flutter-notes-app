import 'package:flutter/material.dart';
import 'package:flutter_notes_app/note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;

  const NoteList(this.notes);

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Center(
        child: Text('No notes created yet!'),
      );
    } else {
      return StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          var note = notes[index];
          return _buildNote(note);
        },
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 1 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      );
    }
  }

  Widget _buildNote(Note note) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    note.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // decoration: note.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    note.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      // decoration: note.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    '${note.created.hour}:${note.created.minute}:'
                    '${note.created.second}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                iconSize: 30,
                icon: Icon(Icons.edit),
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(Icons.delete),
                onPressed: () {
                  note.delete();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
