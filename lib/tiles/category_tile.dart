import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p_a/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        child: ListTile(
          leading: Image.network(snapshot.data["icon"]),
          title: Text(snapshot.data["title"]),
          subtitle: Text(snapshot.data["subtitle"]),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Color.fromARGB(255, 0, 60, 102),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryScreen(snapshot)));
          },
        ));
  }
}
