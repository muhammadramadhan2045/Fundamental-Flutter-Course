import 'package:flutter/material.dart';
import 'package:local_db/model/note.dart';
import 'package:local_db/provider/db_provider.dart';
import 'package:provider/provider.dart';

class NoteAddUpdatePage extends StatefulWidget {
  final Note? note;
  const NoteAddUpdatePage({super.key, this.note});

  @override
  State<NoteAddUpdatePage> createState() => _NoteAddUpdatePageState();
}

class _NoteAddUpdatePageState extends State<NoteAddUpdatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _isUpdate = true;
      _titleController.text = widget.note?.title ?? '';
      _descriptionController.text = widget.note?.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!_isUpdate) {
                    final note = Note(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    Provider.of<DbProvider>(context, listen: false)
                        .addNote(note);
                  } else {
                    final note = Note(
                      id: widget.note?.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    Provider.of<DbProvider>(context, listen: false)
                        .updateNoteById(note);

                    Navigator.pop(context);
                  }
                },
                child: Text(_isUpdate == true ? 'Update' : 'Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
