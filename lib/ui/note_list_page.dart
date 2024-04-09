import 'package:flutter/material.dart';
import 'package:local_db/provider/db_provider.dart';
import 'package:provider/provider.dart';

import 'note_add_update_page.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Consumer<DbProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.notes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(value.notes[index].id.toString()),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  value.deleteNoteById(value.notes[index].id ?? 0);
                },
                child: Card(
                  child: ListTile(
                    title: Text(value.notes[index].title),
                    subtitle: Text(value.notes[index].description),
                    onTap: () async {
                      final navigator = Navigator.of(context);

                      final selectedNote =
                          await value.getNotById(value.notes[index].id ?? 0);

                      navigator.push(
                        MaterialPageRoute(
                          builder: (context) => NoteAddUpdatePage(
                            note: selectedNote,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteAddUpdatePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
