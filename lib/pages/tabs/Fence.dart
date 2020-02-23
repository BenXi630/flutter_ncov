import 'package:flutter/material.dart';
import 'package:ncov/http/HttpUtil.dart';
import 'package:ncov/widgets/Loding.dart';
import 'package:ncov/widgets/MyTitle.dart';
import 'package:ncov/util/ScreenAdaper.dart';
import 'package:date_format/date_format.dart';

class FencePage extends StatefulWidget {
  @override
  _FencePageState createState() => _FencePageState();
}

class _FencePageState extends State<FencePage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future _getData() async {
    var result = await HttpUtils.request('/data/getListByCountryTypeService1');
    return result;
  }

  Future _getRecommendData() async {
    var result = await HttpUtils.request('/data/getIndexRecommendList');
    return result;
  }

  Future _getEntriesData() async {
    var result = await HttpUtils.request('/data/getEntries');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MyTitle(
            title: '地区统计',
          ),
          Container(
            height: ScreenAdaper.setHeight(80),
            color: Colors.lightBlueAccent[100],
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      '地区',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenAdaper.setWidth(28)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      '现存确诊',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenAdaper.setWidth(28)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      '累计确诊',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenAdaper.setWidth(28)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      '死亡',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenAdaper.setWidth(28)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      '治愈',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenAdaper.setWidth(28)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: this._getData(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              Widget result;

              if(snap.connectionState == ConnectionState.done) {
                List<Widget> list = List<Widget>();
                for(int i = snap.data.length; i > 0 ; i--) {
                  list.add(
                    DataRow(data: snap.data[i - 1],)
                  );
                }
                result = Column(
                  children: list,
                );
              }else if(snap.connectionState == ConnectionState.waiting) {
                result = Loding();
              }

              return result;
            },
          ),
          MyTitle(
            title: '诊疗',
          ),
          FutureBuilder(
            future: _getEntriesData(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              Widget result;
              if(snap.connectionState == ConnectionState.done) {
                List<Widget> list = List<Widget>();

                for(int i = 0; i < snap.data.length ; i++) {
                  list.add(
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/webview_details', arguments: { 'url': snap.data[i]['linkUrl'], 'title': snap.data[i]['configName'] });
                        },
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              '${snap.data[i]['picUrl']}',
                              width: ScreenAdaper.setWidth(70),
                              height: ScreenAdaper.setWidth(70),
                            ),
                            SizedBox(height: ScreenAdaper.setHeight(10),),
                            Text('${snap.data[i]['configName']}', style: TextStyle(fontSize: ScreenAdaper.setWidth(30)), overflow: TextOverflow.ellipsis, maxLines: 1,),
                            SizedBox(height: ScreenAdaper.setHeight(10),),
                          ],
                        ),
                      ),
                    )
                  );
                }
                
                result = Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: list,
                );
              }else if(snap.connectionState == ConnectionState.waiting) {
                result = Loding();
              }
              return result;
            },
          ),
          MyTitle(
            title: '防护知识',
          ),
          FutureBuilder(
            future: _getRecommendData(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              Widget result;
              if(snap.connectionState == ConnectionState.done) {
                List<Widget> list = List<Widget>();
                for(int i = 0; i < snap.data.length ; i++) {
                  list.add(
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/webview_details', arguments: { 'url': snap.data[i]['linkUrl'], 'title': snap.data[i]['title'] });
                      },
                      title: Text('${snap.data[i]['title']}', maxLines: 2, overflow: TextOverflow.ellipsis,),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: ScreenAdaper.setHeight(18),
                          ),
                          Text('${formatDate(DateTime.fromMillisecondsSinceEpoch(snap.data[i]['modifyTime']), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn])}')
                        ],
                      ),
                      trailing: Container(
                        width: ScreenAdaper.setWidth(160),
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ScreenAdaper.setWidth(10)),
                            image: DecorationImage(
                                image: NetworkImage('${snap.data[i]['imgUrl']}',),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                  );
                }
                result = Column(
                  children: list,
                );
              }else if(snap.connectionState == ConnectionState.waiting) {
                result = Loding();
              }
              return result;
            },
          )
        ],
      ),
    );
  }
}


class DataRow extends StatefulWidget {
  final data;
  DataRow({ this.data });

  @override
  _DataRowState createState() => _DataRowState();
}

class _DataRowState extends State<DataRow> with SingleTickerProviderStateMixin {
  AnimationController _animatedControll;
  Animation _animation;
  Animation _animationHeight;
  Future _future;
  bool _isUnfold = false;

  Future _getData() async {
    var result = await HttpUtils.request('/data/getAreaStat/${widget.data['provinceShortName']}');
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._animatedControll = AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    this._animation = Tween(begin: 0.0, end: 0.25).animate(this._animatedControll);
    this._animationHeight = Tween(begin: 0.0, end: 1.0).animate(this._animatedControll);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenAdaper.setHeight(70),
          color: Colors.grey[200],
          child: InkWell(
            onTap: () {
              this._isUnfold = !this._isUnfold;
              if(this._isUnfold) {
                if(this._future == null) {
                  setState(() {
                    this._future = _getData();
                  });
                }
                this._animatedControll.forward();
              }else {
                this._animatedControll.reverse();
              }
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenAdaper.setWidth(10)),
                    child: Row(
                      children: <Widget>[
                        widget.data['provinceName'] != widget.data['provinceShortName'] ? RotationTransition(
                          turns: _animation,
                          child: Icon(Icons.arrow_right),
                        ) : SizedBox(width: ScreenAdaper.setWidth(44),),
                        Text(
                          '${widget.data['provinceShortName']}',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text('${widget.data['currentConfirmedCount']}', textAlign: TextAlign.center,),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text('${widget.data['confirmedCount']}', textAlign: TextAlign.center,),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text('${widget.data['deadCount']}', textAlign: TextAlign.center,),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text('${widget.data['curedCount']}', textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ),
        FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snap) {
            Widget result = SizedBox();

            if(snap.connectionState == ConnectionState.done) {
              List<Widget> list = List<Widget>();
              for(int i = 0; i < snap.data[0]['cities'].length ; i++) {
                list.add(
                  SizeTransition(
                    axis: Axis.vertical,
                    sizeFactor: _animationHeight,
                    child: Container(
                      height: ScreenAdaper.setHeight(60),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.only(left: ScreenAdaper.setWidth(10)),
                                child: Text(
                                  '${snap.data[0]['cities'][i]['cityName']}',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text('${snap.data[0]['cities'][i]['currentConfirmedCount']}', textAlign: TextAlign.center,),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text('${snap.data[0]['cities'][i]['confirmedCount']}', textAlign: TextAlign.center,),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text('${snap.data[0]['cities'][i]['deadCount']}', textAlign: TextAlign.center,),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text('${snap.data[0]['cities'][i]['curedCount']}', textAlign: TextAlign.center,),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                );
              }
              result = Column(
                children: list,
              );
            }

            return result;
          },
        ),
        Divider(height: 0.5)
      ],
    );
  }
}
