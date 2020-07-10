import 'package:flutter/material.dart';
import 'package:p_a/screens/votacoes_screen.dart';
import 'package:p_a/tabs/artigos_tab.dart';
import 'package:p_a/tabs/home_tab.dart';

import 'home_video_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_pageController CONFIGURAR NAVEGAÇÃO

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.lightBlue,
            primaryColor: Colors.black87,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.white))),
        child: BottomNavigationBar(
          currentIndex: _page,
          type: BottomNavigationBarType.fixed,
          onTap: (p) {
            _pageController.animateToPage(p,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Notícias")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                ),
                title: Text(
                  "Artigos",
                )),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              title: Text("Vídeos"),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance),
                title: Text(
                  "Votações",
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (p) {
            setState(() {
              _page = p;
            });
          },
          children: <Widget>[
            HomeTab(),
            Scaffold(
              appBar: AppBar(
                title: Text(
                  "Artigos",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: ArtigosTab(),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text(
                  "Vídeos",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: HomeVideoScreen(),
            ),
            VotacoesScreen(),
          ],
        ),
      ),
    );
  }
}
