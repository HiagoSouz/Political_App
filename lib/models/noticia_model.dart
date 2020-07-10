import 'package:cloud_firestore/cloud_firestore.dart';


class Noticia {
  String id;
  String title;
  String author;
  String description;
  String date;
  String images;
  String subtitle;

  Noticia({
    this.id,
    this.title,
    this.author,
    this.description,
    this.date,
    this.images,
    this.subtitle,
  });

  Noticia.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    images = snapshot.data["images"];
    author = snapshot.data["autor"];
    date = snapshot.data["date"];
    subtitle = snapshot.data["subtitle"];
  }
}
