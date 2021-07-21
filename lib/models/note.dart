class Note {
  int id;
  String title;
  String content;
  String dateTimeEdited;
  String dateTimeCreated;
  int isImageAttached;
  String imagePath;


  Note({
    this.id,
    this.content,
    this.title,
    this.dateTimeEdited,
    this.dateTimeCreated,
    this.isImageAttached,
    this.imagePath
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "dateTimeEdited": dateTimeEdited,
      "dateTimeCreated": dateTimeCreated,
      "isImageAttached": isImageAttached,
      "imagePath": imagePath
    };
  }
}
