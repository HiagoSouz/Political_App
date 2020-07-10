import 'package:flutter/material.dart';
import 'package:p_a/data/artigos_data.dart';
import 'package:p_a/screens/artigos_screen.dart';


class ArtigosTile extends StatelessWidget {
  final String type;
  final ArtigosData product;

  ArtigosTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    double tamanho = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ArtigosScreen(product)));
      },
      child: Stack(
        children: <Widget>[
          Card(
              elevation: 10,
              child: type == "grid"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      //deixa imagens esticadas REVISAR
                      mainAxisAlignment: MainAxisAlignment.start,
                      //imagem no inicio|topo
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio:
                              0.9, //1.0 para quadradas, 0.8 para esticadas
                          child: Image.network(
                            product.images[0],
                            fit: BoxFit
                                .fill,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  product.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: tamanho / 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 30,
                          child: Image.network(
                            product.images[0],
                            fit: BoxFit.cover,
                            height: tamanho / 4,
                          ),
                        ),
                        Flexible(
                          flex: 60,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  product.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 10,
                          child: Container(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
        ],
      ),
    );
  }
}
