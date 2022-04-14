// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:taskapp/database/notes_database.dart';
import 'package:taskapp/model/note.dart';
import 'package:taskapp/widget/note_card_widget.dart';

import 'edit_note_page.dart';
import 'note_detail_page.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: customSearchDelegate(note: notes));
              },
            ),
            SizedBox(width: 12)
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.white],
                  //       colors: [
                  //   Color(0xFFc7b636),
                  //   Colors.deepOrangeAccent,
                  //   Color(0xFFfe4a97),
                  //   Color(0XFFE17763),
                  //   Color(0XFF68998C),
                  // ], stops: [
                  //   0,
                  //   0.1,
                  //   0.3,
                  //   0.6,
                  //   0.9,
                  // ],
                  // stops: [0.5, 1.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : notes.isEmpty
                    ? Text(
                        'No Notes',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      )
                    : SafeArea(child: buildNotes()),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}

class customSearchDelegate extends SearchDelegate {
  List<Note> note;
  customSearchDelegate({required this.note});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    ); // IconButton
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Note> matchQuery = [];
    for (var item in note) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: matchQuery.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final note = matchQuery[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailPage(noteId: note.id!),
            ));
          },
          child: NoteCardWidget(note: note, index: index),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Note> matchQuery = [];
    for (var item in note) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: matchQuery.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final note = matchQuery[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailPage(noteId: note.id!),
            ));
          },
          child: NoteCardWidget(note: note, index: index),
        );
      },
    );
  }
}
