import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/news_webview_notifier.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        elevation: 0.8,
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          'Yess Nutrition',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
          color: primaryColor,
          tooltip: 'Close',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _webViewController.reload(),
            icon: const Icon(Icons.refresh_rounded),
            color: primaryColor,
            tooltip: 'Reload',
          ),
          IconButton(
            onPressed: () {
              Future.wait([
                _webViewController.clearCache(),
                CookieManager().clearCookies(),
              ]).then((_) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    Utilities.createSnackBar('Cache berhasil dihapus'),
                  );
              });
            },
            icon: const Icon(Icons.cached_rounded),
            color: primaryColor,
            tooltip: 'Clear Cache',
          ),
        ],
      ),
      body: Consumer<NewsWebViewNotifier>(
        builder: (context, webViewNotifier, child) {
          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.disabled,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onProgress: (progress) {
                  webViewNotifier.progress = progress / 100;
                },
              ),
              if (webViewNotifier.progress != 1) ...[
                LinearProgressIndicator(
                  value: webViewNotifier.progress,
                  color: secondaryBackgroundColor,
                  backgroundColor: secondaryColor,
                )
              ],
            ],
          );
        },
      ),
    );
  }
}