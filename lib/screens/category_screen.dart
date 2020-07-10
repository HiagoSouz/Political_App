import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p_a/data/artigos_data.dart';
import 'package:p_a/tiles/product_tile.dart';


class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: Text(
              snapshot.data["title"],
              style: TextStyle(color: Colors.white),
            ),
            /* actions: <Widget>[              //barra de pesquisa, falta implementar
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  showSearch(context: context, delegate: DataSearch());
                },
              ),
            ],*/
            bottom: TabBar(
              indicatorColor: Colors.white, //cor da mudança de barra
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.grid_on,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("products")
                  .document(snapshot.documentID)
                  .collection("items")
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                            padding: EdgeInsets.all(4.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              ArtigosData data = ArtigosData.fromDocument(
                                  snapshot.data.documents[index]);
                              data.category = this.snapshot.documentID;
                              return ArtigosTile("grid", data);
                            }),
                        ListView.builder(
                            padding: EdgeInsets.all(4.0),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              ArtigosData data = ArtigosData.fromDocument(
                                  snapshot.data.documents[index]);
                              data.category = this.snapshot.documentID;
                              return ArtigosTile("list", data);
                            })
                      ]);
              })),
    );
  }
}
