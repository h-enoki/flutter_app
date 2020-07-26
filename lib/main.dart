import 'package:flutter/material.dart';
import './views/pages/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Stateful', home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ページ切り替え用のコントローラを定義
  PageController _pageController;

  //ページインデックス保存用
  int _currentIndex = 0;

  //表示するページの配列
  final _pageWidgets = [
    PageWidget(color: Colors.white, title: 'Home'),
    PageWidget(color: Colors.blue, title: 'Album'),
    PageWidget(color: Colors.orange, title: 'Chat'),
  ];

  //ナビゲーションメニューの一覧
  List<BottomNavigationBarItem> myBottomNavBarItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
      BottomNavigationBarItem(icon: Icon(Icons.photo_album), title: Text('Album')),
      BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Chat')),
    ];
  }

  @override
  void initState() {
    super.initState();
    // コントローラ作成
    _pageController = PageController(
      initialPage: _currentIndex, // 初期ページの指定
    );
  }

  @override
  void dispose() {
    // コントローラ破棄
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar'),
      ),
      body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            _pageWidgets.elementAt(0),
            _pageWidgets.elementAt(1),
            _pageWidgets.elementAt(2),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        items: myBottomNavBarItems(),
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onPageChanged,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
