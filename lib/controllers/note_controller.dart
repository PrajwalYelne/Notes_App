import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

import '../models/note.dart';
import '../services/database_helper.dart';

class NoteController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  var notes = List<Note>();
  int contentWordCount = 0;
  int contentCharCount = 0;

  @override
  void onInit() {
    getAllNotes();
    super.onInit();
  }

  bool isEmpty() {
    if (notes.length == 0)
      return true;
    else
      return false;
  }

  void addNoteToDatabase() async {
    String title = titleController.text;
    String content = contentController.text;
    if (title.isNullOrBlank) {
      title = "Unnamed Title";
    }
    Note note = Note(
      title: title,
      content: content,
      dateTimeEdited:
          DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()),
      dateTimeCreated:
          DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
      isImageAttached: 0,
      imagePath: ""

    );
    await DatabaseHelper.instance.addNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void deleteNote(int id) async {
    Note note = Note(
      id: id,
    );
    await DatabaseHelper.instance.deleteNote(note);
    getAllNotes();
  }

  void deleteAllNotes() async {
    await DatabaseHelper.instance.deleteAllNotes();
    getAllNotes();
  }


  void updateNote(Note oldNote) async {
    final title = titleController.text;
    final content = contentController.text;
    Note note = Note(
      id: oldNote.id,
      title: title,
      content: content,
      dateTimeEdited:
          DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
      dateTimeCreated: oldNote.dateTimeCreated,
      isImageAttached: oldNote.isImageAttached,
      imagePath: oldNote.imagePath
    );
    await DatabaseHelper.instance.updateNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void delteImage(Note oldNote) async {
    Note note = Note(
        id: oldNote.id,
        title: oldNote.title,
        content: oldNote.content,
        dateTimeEdited:
        DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
        dateTimeCreated: oldNote.dateTimeCreated,
        isImageAttached: oldNote.isImageAttached,
        imagePath: oldNote.imagePath
    );
    await DatabaseHelper.instance.updateNote(note);
    contentWordCount = wordCount(oldNote.content);
    contentCharCount = charCount(oldNote.content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    Get.back();
  }

  void getAllNotes() async {
    notes = await DatabaseHelper.instance.getNoteList();
    update();
  }

  void shareNote(String title, String content, String dateTimeEdited) {
    Share.share("$title \n\n$dateTimeEdited\n\n$content");
  }

  void addImageMeta(int id, Note Mnote) async {
    Note note = Note(
      id: id,
      title: Mnote.title,
      content: Mnote.content,
      dateTimeEdited:
      DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
      dateTimeCreated: Mnote.dateTimeCreated,
      isImageAttached: Mnote.isImageAttached,
      imagePath: Mnote.imagePath
    );
    await DatabaseHelper.instance.updateNote(note);
    contentWordCount = wordCount(Mnote.content);
    contentCharCount = charCount(Mnote.content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
  }


}
