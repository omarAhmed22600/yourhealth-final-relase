import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Resources extends StatelessWidget {
  const Resources({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'resources',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('our resources'),
        ),
        body: const WebView(
          initialUrl: "https://www.moh.gov.om/ar/1",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
