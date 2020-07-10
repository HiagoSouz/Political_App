import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:pie_chart/pie_chart.dart';

class VotacoesScreen extends StatefulWidget {
  @override
  _VotacoesScreenState createState() => _VotacoesScreenState();
}

class _VotacoesScreenState extends State<VotacoesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: Text("Votações", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            bottom: TabBar(
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              indicatorColor: Colors.white, //cor da mudança de barra
              tabs: <Widget>[
                Tab(
                  text: "Senado",
                ),
                Tab(
                  text: "Câmara",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              CustomScrollView(slivers: <Widget>[
                FutureBuilder<QuerySnapshot>(
                    future: Firestore.instance
                        .collection("votacoes")
                        .getDocuments(),
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
                              ? Card(
                                  elevation: 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Theme(
                                        data: ThemeData(
                                            canvasColor: Colors.lightBlue),
                                        child: ExpansionTile(
                                          title: Text(
                                            snapshot.data.documents[index]
                                                .data["title"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot
                                                              .data
                                                              .documents[index]
                                                              .data["res"],
                                                          style: TextStyle(
                                                              color: snapshot.data
                                                                              .documents[index].data[
                                                                          "res"] ==
                                                                      "Aprovado"
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 20)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 20),
                                              child: Container(
                                                child: PieChart(
                                                  colorList: [
                                                    Colors.lightBlue,
                                                    Colors.red,
                                                    Colors.yellow
                                                  ],
                                                  dataMap: Grafico(
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["Sim"],
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["Nao"],
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["Abs"],
                                                  ),
                                                  animationDuration: Duration(
                                                      milliseconds: 800),
                                                  chartLegendSpacing: 32.0,
                                                  chartRadius:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2.7,
                                                  showChartValuesInPercentage:
                                                      true,
                                                  showChartValues: true,
                                                  showChartValuesOutside: false,
                                                  chartValueBackgroundColor:
                                                      Colors.transparent,
                                                  showLegends: true,
                                                  legendPosition:
                                                      LegendPosition.right,
                                                  decimalPlaces: 1,
                                                  showChartValueLabel: true,
                                                  chartValueStyle:
                                                      defaultChartValueStyle
                                                          .copyWith(
                                                    color: Colors.blueGrey[900]
                                                        .withOpacity(0.9),
                                                  ),
                                                  chartType: ChartType.disc,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: <Widget>[
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "Ementa: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontSize: 20),
                                                        ),
                                                        TextSpan(
                                                            text: snapshot
                                                                    .data
                                                                    .documents[
                                                                        index]
                                                                    .data[
                                                                "ementa"]),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                          childCount: generatedList.length,
                        ),
                      );
                    }),
              ]),
              CustomScrollView(slivers: <Widget>[
                FutureBuilder<QuerySnapshot>(
                    future:
                        Firestore.instance.collection("senado").getDocuments(),
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
                              ? Card(
                                  elevation: 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Theme(
                                        data: ThemeData(
                                            canvasColor: Colors.lightBlue),
                                        child: ExpansionTile(
                                          title: Text(
                                            snapshot.data.documents[index]
                                                .data["title"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: snapshot
                                                          .data
                                                          .documents[index]
                                                          .data["res"],
                                                      style: TextStyle(
                                                          color: snapshot
                                                                          .data
                                                                          .documents[
                                                                              index]
                                                                          .data[
                                                                      "res"] ==
                                                                  "Aprovado"
                                                              ? Colors.green
                                                              : Colors.red,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 20),
                                              child: Container(
                                                child: PieChart(
                                                  colorList: [
                                                    Colors.lightBlue,
                                                    Colors.red,
                                                    Colors.yellow,
                                                    Colors.black
                                                  ],
                                                  dataMap: Grafico(
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["Sim"],
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["Nao"],
                                                    snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["Abs"],
                                                  ),
                                                  animationDuration: Duration(
                                                      milliseconds: 1200),
                                                  chartLegendSpacing: 32.0,
                                                  chartRadius:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2.7,
                                                  showChartValuesInPercentage:
                                                      true,
                                                  showChartValues: true,
                                                  showChartValuesOutside: false,
                                                  chartValueBackgroundColor:
                                                      Colors.transparent,
                                                  showLegends: true,
                                                  legendPosition:
                                                      LegendPosition.right,
                                                  decimalPlaces: 1,
                                                  showChartValueLabel: true,
                                                  chartValueStyle:
                                                      defaultChartValueStyle
                                                          .copyWith(
                                                    color: Colors.blueGrey[900]
                                                        .withOpacity(0.9),
                                                  ),
                                                  chartType: ChartType.disc,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: <Widget>[
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: "Ementa: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontSize: 20),
                                                        ),
                                                        TextSpan(
                                                            text: snapshot
                                                                    .data
                                                                    .documents[
                                                                        index]
                                                                    .data[
                                                                "ementa"]),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                          childCount: generatedList.length,
                        ),
                      );
                    }),
              ]),
            ],
          )),
    );
  }

  Map Grafico(int Sim, int Nao, int Abs) {
    Map<String, double> dataMap = new Map();
    double sim;
    double nao;
    double abs;

    sim = Sim.toDouble();
    nao = Nao.toDouble();
    abs = Abs.toDouble();

    dataMap.putIfAbsent("Sim", () => sim);
    dataMap.putIfAbsent("Não", () => nao);
    dataMap.putIfAbsent("Não Votaram", () => abs);

    return dataMap;
  }
}

/*
Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Sim", () => 79);
    dataMap.putIfAbsent("Não", () => 4);
    dataMap.putIfAbsent("Abstenções", () => 0);
    dataMap.putIfAbsent("Impedidos", () => 5);

    return
      ListView(children: <Widg Container(
      child:
      PieChart(
        colorList: [Colors.lightBlue,Colors.red,Colors.yellow,Colors.black],
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32.0,
        chartRadius: MediaQuery.of(context).size.width / 2.7,
        showChartValuesInPercentage: true,
        showChartValues: true,
        showChartValuesOutside: false,
        chartValueBackgroundColor: Colors.transparent,
        showLegends: true,
        legendPosition: LegendPosition.right,
        decimalPlaces: 1,
        showChartValueLabel: true,
        chartValueStyle: defaultChartValueStyle.copyWith(
          color: Colors.blueGrey[900].withOpacity(0.9),
        ),
        chartType: ChartType.ring,
      )
      ,
    ),et>[

    ],);
  }
 */
