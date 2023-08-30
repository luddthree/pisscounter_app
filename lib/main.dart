import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  String url = 'https://www.pisscounter.com/app';

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navigation) {
            if (navigation.url != url) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    super.initState();
  }

  void _changeUrl(String newUrl) {
    setState(() {
      url = newUrl;
      controller.loadRequest(Uri.parse(url));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'PissMap',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            _changeUrl('https://www.pisscounter.com/app');
          } else if (index == 1) {
            _changeUrl('https://www.pisscounter.com/abapp');
          } else if (index == 2) {
            _changeUrl('https://www.pisscounter.com/mapapp');
          }
        },
      ),
    );
  }
}
