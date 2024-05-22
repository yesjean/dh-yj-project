import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:go_router/go_router.dart';


class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {

  
  final WebViewController _controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://demo.real-report.com/'));
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        title: const Text('Flutter Simple Example'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // GoRouter를 사용하여 홈으로 이동합니다.
            GoRouter.of(context).go('/');
          },
        ),
      ),
    body: WebViewWidget(controller: _controller),
  );
}
}
