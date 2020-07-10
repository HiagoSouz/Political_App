import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_a/screens/noticia_screen.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final _itemExtent = 100.0; //tamanho das tabs da noticia

    double largura = MediaQuery.of(context).size.width;
    double tamanho = MediaQuery.of(context).size.height;
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              //cor inicial do degrade da página principal
              Colors.white,
              //cor final do degrade da página principal
            ],
            begin: Alignment.topLeft,
            //inicio e fim do degrade da página principal
            end: Alignment.bottomRight,
          )),
        );

    return SafeArea(
        child: Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              floating: true,
              snap: true,
              //Deslizando para baixo, a barra some com esse comando
              backgroundColor: Colors.transparent,
              //Deslizando para baixo, a barra some com esse comando

              elevation: 0.0,
              //elevação da barra
              flexibleSpace: FlexibleSpaceBar(
                title: Image.asset("images/LogoApp.png"), //barra principal
                centerTitle: true,
                titlePadding: EdgeInsets.only(bottom: 5, top: 5),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
                future:
                    Firestore.instance.collection("noticias").getDocuments(),
                builder: (context, snapshot) {
                  int y;
                  if (snapshot.hasData)
                    y = snapshot.data.documents.length;
                  else
                    y = 0;
                  final generatedList =
                      List.generate(y, (index) => 'Item $index');
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => snapshot.hasData
                          ? GestureDetector(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => NoticiaScreen(
                                        images: snapshot.data.documents[index]
                                            .data["images"],
                                        title: snapshot.data.documents[index]
                                            .data["title"],
                                        subtitle: snapshot.data.documents[index]
                                            .data["subtitle"],
                                        description: snapshot
                                            .data
                                            .documents[index]
                                            .data["description"],
                                        date: snapshot
                                            .data.documents[index].data["date"],
                                        author: snapshot.data.documents[index]
                                            .data["author"],
                                      ),
                                    ),
                                  ),
                              child: Container(
                                  height: tamanho / 5,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      elevation: 20,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.6),
                                                  BlendMode.dstATop),
                                              image: NetworkImage(
                                                snapshot.data.documents[index]
                                                    .data["images"],
                                              ),
                                              fit: BoxFit.fill,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: tamanho * 0.011856,
                                                  ),
                                                  Text(
                                                      snapshot.hasData
                                                          ? snapshot
                                                              .data
                                                              .documents[index]
                                                              .data["author"]
                                                          : "Carregando...",
                                                      style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontSize: tamanho *
                                                                0.018970,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(
                                                    height: tamanho * 0.015971,
                                                  ),
                                                  Text(
                                                      snapshot.hasData
                                                          ? snapshot
                                                              .data
                                                              .documents[index]
                                                              .data["title"]
                                                          : "Carregando...",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        textStyle: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      textAlign:
                                                          TextAlign.start),
                                                  SizedBox(
                                                    height: tamanho * 0.004971,
                                                  ),
                                                  Text(
                                                    snapshot.hasData
                                                        ? snapshot
                                                            .data
                                                            .documents[index]
                                                            .data["subtitle"]
                                                        : "Carregando...",
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ))))
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      childCount: generatedList.length,
                    ),
                  );
                }),
          ],
        )
      ],
    ));
  }
}
