import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/webview_notifier.dart';

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
    final popUpMenuTextStyle =
        GoogleFonts.plusJakartaSans(color: primaryTextColor);

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
          PopupMenuButton(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            icon: const Icon(
              Icons.more_vert_rounded,
              color: primaryColor,
            ),
            itemBuilder: (context) {
              return <PopupMenuItem>[
                PopupMenuItem(
                  textStyle: popUpMenuTextStyle,
                  onTap: () async {
                    final url = Uri.parse(widget.url);

                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(
                        Icons.open_in_browser_rounded,
                        color: primaryColor,
                      ),
                      SizedBox(width: 12),
                      Text('Buka di Browser'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  textStyle: popUpMenuTextStyle,
                  onTap: () async {
                    await _webViewController.reload();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(
                        Icons.refresh_rounded,
                        color: primaryColor,
                      ),
                      SizedBox(width: 12),
                      Text('Muat Ulang'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  textStyle: popUpMenuTextStyle,
                  onTap: () {
                    Future.wait([
                      // clear caches
                      _webViewController.clearCache(),
                      // clear cookies
                      CookieManager().clearCookies(),
                    ]).then((_) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          Utilities.createSnackBar('Cache berhasil dihapus'),
                        );
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(
                        Icons.cached_rounded,
                        color: primaryColor,
                      ),
                      SizedBox(width: 12),
                      Text('Hapus Cache'),
                    ],
                  ),
                ),
              ];
            },
            tooltip: 'More',
          ),
        ],
      ),
      body: Consumer<WebViewNotifier>(
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
