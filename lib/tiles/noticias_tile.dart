import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticiasTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  NoticiasTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              snapshot.data["icon"],
            ), //seleciona o icone no firestore
          ),
          title: Text(snapshot.data["title"]),
          subtitle: Text(snapshot.data["subtitle"]),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {},
        ));
  }
}
