import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/note.dart';
import '../api/note_api.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future fetchNotes() async {
    final response = await NoteApi.getNotes();
    final decodedResponse = jsonDecode(response.body);
    _notes =
        (decodedResponse['data'] as List).map((e) => Note.fromJson(e)).toList();
  }

  Future addNote(Note note) async {
    await NoteApi.createNote(note.toJson());
    _notes.add(note);
    notifyListeners();
  }

  Future updateNote(Note note) async {
    await NoteApi.updateNote(note.id!, note.toJson());
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) _notes[index] = note;
    notifyListeners();
  }

  Future deleteNote(String id) async {
    await NoteApi.deleteNote(id);
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
