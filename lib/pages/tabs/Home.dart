import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ncov/http/HttpUtil.dart';
import 'package:ncov/widgets/Loding.dart';
import '../../util/ScreenAdaper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List _list = [];
  
  void _getData() async {
    var result = await HttpUtils.request('/data/getTimelineService');
    setState(() {
      this._list = result;
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return this._list.length != 0 ? Container(
      color: Color.fromRGBO(200, 200, 200, 0.15),
      child: ListView.builder(
        itemCount: this._list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: ScreenAdaper.setWidth(15), horizontal: ScreenAdaper.setWidth(20)),
            padding: EdgeInsets.all(ScreenAdaper.setWidth(16)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenAdaper.setWidth(20)),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/webview_details', arguments: { 'url': this._list[index]['sourceUrl'], 'title': this._list[index]['title'] });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${this._list[index]['title']}',
                    style: TextStyle(
                      fontSize: ScreenAdaper.setWidth(32),
                    ),
                  ),
                  SizedBox(height: ScreenAdaper.setHeight(14),),
                  Text(
                    '${this._list[index]['summary']}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenAdaper.setWidth(26)
                    ),
                  ),
                  SizedBox(height: ScreenAdaper.setHeight(14),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '时间：${this._list[index]['pubDateStr']}',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenAdaper.setWidth(28)
                        ),
                      ),
                      Text(
                        '来源：${this._list[index]['infoSource']}',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenAdaper.setWidth(28)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    ) : Loding();
  }
}
