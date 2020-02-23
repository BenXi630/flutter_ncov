import 'package:flutter/material.dart';
import 'package:ncov/util/ScreenAdaper.dart';

class MyTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  MyTitle({ @required this.title, this.subtitle = '' });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenAdaper.setWidth(20),
          vertical: ScreenAdaper.setWidth(14)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenAdaper.setWidth(12),
                height: ScreenAdaper.setHeight(30),
                margin: EdgeInsets.only(right: ScreenAdaper.setWidth(16)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenAdaper.setWidth(6)),
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(
                '${this.title}',
                style: TextStyle(
                    fontSize: ScreenAdaper.setWidth(30)
                ),
              )
            ],
          ),
          Text(
            '${this.subtitle}',
            style: TextStyle(
                color: Colors.black45
            ),
          )
        ],
      ),
    );
  }
}
