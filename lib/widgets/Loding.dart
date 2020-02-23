import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Center(
      child: Container(
        padding: EdgeInsets.all(20 * rpx),
        child: SpinKitRotatingCircle(
          color: Theme.of(context).accentColor,
          size: 50 * rpx,
        ),
      ),
    );
  }
}
