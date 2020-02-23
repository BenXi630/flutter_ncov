import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/WebViewDetails.dart';

final routes = {
  '/': (context) => Tabs(),
  '/webview_details': (context, { arguments }) => WebViewDetailsPage(arguments: arguments),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if(pageContentBuilder != null) {
    if(settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context, arguments: settings.arguments)
      );
      return route;
    }else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context)
      );
      return route;
    }
  }
};