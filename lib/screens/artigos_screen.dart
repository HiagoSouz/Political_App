import 'package:flutter/material.dart';
import 'package:p_a/data/artigos_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtigosScreen extends StatefulWidget {
  final ArtigosData product;

  ArtigosScreen(this.product);

  @override
  _ArtigosScreenState createState() => _ArtigosScreenState(product);
}

class _ArtigosScreenState extends State<ArtigosScreen> {
  @override
  final ArtigosData product;
  String category;
  String size;
  String observacao;
  double qtd;

  _ArtigosScreenState(this.product);

  Widget build(BuildContext context) {
    double tamanho = MediaQuery.of(context).size.height;
    double largura = MediaQuery.of(context).size.width;

    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            product.title,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: tamanho * 0.003557,
            ),
            Card(
              elevation: 10,
              child: SizedBox(
                height: tamanho * 0.4,
                child: Image.network(
                  (product.images[0]),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(tamanho * 0.018970),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      product.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: tamanho * 0.026084,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(height: tamanho * 0.022527),
                    Row(
                      children: <Widget>[
                        Text(
                          "Autor(a): ",
                          style: TextStyle(
                              fontSize: tamanho * 0.023713,
                              fontWeight: FontWeight.w400,
                              color: primaryColor),
                        ),
                        Text(
                          product.autor,
                          style: TextStyle(
                            fontSize: tamanho * 0.018970,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Número de Páginas: ",
                          style: TextStyle(
                              fontSize: tamanho * 0.023713,
                              fontWeight: FontWeight.w400,
                              color: primaryColor),
                        ),
                        Text(
                          product.paginas,
                          style: TextStyle(
                            fontSize: tamanho * 0.018970,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Resumo autoral:",
                      style: TextStyle(
                          fontSize: tamanho * 0.023713,
                          fontWeight: FontWeight.w400,
                          color: primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: RaisedButton(
                          color: Colors.lightBlueAccent,
                          onPressed: _pdf,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.file_download,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Baixar PDF",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          )),
                    )
                  ]),
            )
          ],
        ));
  }

  _pdf() async {
    var url = product.pdf;
    launch("$url");
  }
}
