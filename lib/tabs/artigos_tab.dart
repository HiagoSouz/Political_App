import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p_a/tiles/category_tile.dart';

class ArtigosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("artigos").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            GridView.count(
              crossAxisCount: 2,
              children: List.generate(20, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              }),
            );
            var dividedTiles = ListTile.divideTiles(
              context: context,
              tiles: snapshot.data.documents.map((doc) {
                return CategoryTile(doc);
              }).toList(),
            ).toList();

            return ListView(
              children: dividedTiles,
            );
          }
        });
  }
}

