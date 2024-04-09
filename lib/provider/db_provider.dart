import 'package:flutter/material.dart';
import 'package:local_db/model/note.dart';
import 'package:local_db/utils/database_helper.dart';

class DbProvider extends ChangeNotifier {
  List<Note> _notes = [];

  late DatabaseHelper _databaseHelper;

  List<Note> get notes => _notes;

  DbProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllNotes();
  }

  void _getAllNotes() async {
    _notes = await _databaseHelper.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _databaseHelper.insertNote(note);
    _getAllNotes();
  }

  Future<Note> getNotById(int id) async {
    return await _databaseHelper.getNoteById(id);
  }

  void updateNoteById(Note note) async {
    await _databaseHelper.updateNote(note);
    _getAllNotes();
  }

  void deleteNoteById(int id) async {
    await _databaseHelper.deleteNote(id);
    _getAllNotes();
  }
}
