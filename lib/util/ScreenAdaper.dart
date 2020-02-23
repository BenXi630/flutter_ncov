import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdaper {
  static init(context) {
    ScreenUtil.init(context, width: 750, height: 1334);
  }

  static setWidth(double w) {
    return ScreenUtil().setWidth(w);
  }
  static setHeight(double h) {
    return ScreenUtil().setHeight(h);
  }
}