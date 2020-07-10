import 'package:cloud_firestore/cloud_firestore.dart';

class ArtigosData {
  String category;
  String id;
  String title;
  String description;
  List images;
  String autor;
  String paginas;
  String pdf;

  ArtigosData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    pdf = snapshot.data["pdf"];
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    images = snapshot.data["images"];
    autor = snapshot.data["autor"];
    paginas = snapshot.data["paginas"];
  }

  Map<String, dynamic> toResumedMap() {
    return {"title": title, "description": description};
  }
}
