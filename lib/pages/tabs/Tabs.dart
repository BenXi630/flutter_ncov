import 'package:flutter/material.dart';
import '../../util/ScreenAdaper.dart';
import 'Home.dart';
import 'Rumours.dart';
import 'Fence.dart';
import 'Knowledge.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  int _current = 0;
  PageController _pageController;

  List<String> _titles = [
    '首页',
    '辟谣',
    '防护合集',
    '疾病知识'
  ];

  List<Widget> _pages = [
    HomePage(),
    RumoursPage(),
    FencePage(),
    KnowledgePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _current);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${_titles[_current]}'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/webview_details', arguments: { 'url': 'https://github.com/BenXi630/flutter_ncov', 'title': '开源地址' });
            },
            child: Text('开源地址', style: TextStyle(color: Colors.white),),
          )
        ],
        elevation: 0,
      ),
      body: PageView(
          controller: _pageController,
          children: _pages,
          physics: NeverScrollableScrollPhysics()
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black54,
        currentIndex: this._current,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() {
            this._current = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_busy),
            title: Text('辟谣')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            title: Text('防护合集')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horizontal_circle),
            title: Text('疾病知识')
          )
        ],
      ),
    );
  }
}
