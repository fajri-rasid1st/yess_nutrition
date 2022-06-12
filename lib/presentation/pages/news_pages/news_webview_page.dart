import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/news_webview_notifier.dart';

class NewsWebViewPage extends StatefulWidget {
  final String url;

  const NewsWebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<NewsWebViewPage> createState() => _NewsWebViewPageState();
}

class _NewsWebViewPageState extends State<NewsWebViewPage> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        elevation: 2,
        title: const Text(
          'NutriNews',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close_rounded,
            color: primaryColor,
            size: 26,
          ),
          tooltip: 'Close',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _webViewController.reload(),
            icon: const Icon(
              Icons.refresh_outlined,
              color: primaryColor,
              size: 26,
            ),
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
                    Utilities.createSnackBar('Cache berhasil dihapus.'),
                  );
              });
            },
            icon: const Icon(
              Icons.cleaning_services_rounded,
              color: primaryColor,
            ),
            tooltip: 'Clear Cache',
          ),
        ],
      ),
      body: Consumer<NewsWebViewNotifier>(
        builder: (context, webview, child) {
          return Column(
            children: <Widget>[
              if (webview.progress != 1) ...[
                LinearProgressIndicator(
                  value: webview.progress,
                  color: secondaryBackgroundColor,
                  backgroundColor: secondaryColor,
                )
              ],
              Expanded(
                child: WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.disabled,
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                  },
                  onPageStarted: (url) {
                    // remove header if exist
                    _webViewController.runJavascript(
                      "document.getElementsByTagName('header')[0].style.display='none'",
                    );

                    // remove footer if exist
                    _webViewController.runJavascript(
                      "document.getElementsByTagName('footer')[0].style.display='none'",
                    );
                  },
                  onProgress: (progress) {
                    webview.progress = progress / 100;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
