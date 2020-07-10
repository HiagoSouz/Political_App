import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticiaScreen extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final String images;
  final String author;
  final String subtitle;

  //final String likes;

  NoticiaScreen(
      {this.title,
      this.description,
      this.date,
      this.images,
      this.subtitle,
      this.author});

  @override
  _NoticiaScreenState createState() => _NoticiaScreenState();
}

class _NoticiaScreenState extends State<NoticiaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 5,
              child: Image.network(
                widget.images,
                height: 300,
                width: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w600),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.date + ' - ' + widget.author,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w400),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Divider(),
                  HtmlWidget(
                    widget.description,
                    textStyle: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
