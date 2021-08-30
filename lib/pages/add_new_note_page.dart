import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/note_controller.dart';

class AddNewNotePage extends StatelessWidget {
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "New Note",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.titleController,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                  border: InputBorder.none,
                ),
              ),
              TextField(
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: controller.contentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Content",
                  hintStyle: TextStyle(
                    fontSize: 22,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNoteToDatabase();
        },
        child: Icon(
          Icons.check,
        ),
      ),
    );
  }
}

