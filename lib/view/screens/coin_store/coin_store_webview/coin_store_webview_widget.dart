import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/url_container.dart';
import '../../../components/snack_bar/show_custom_snackbar.dart';

class CoinStroreWebViewWidget extends StatefulWidget {
  const CoinStroreWebViewWidget({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<CoinStroreWebViewWidget> createState() => _CoinStroreWebViewWidgetState();
}

class _CoinStroreWebViewWidgetState extends State<CoinStroreWebViewWidget> {
  @override
  void initState() {
    url = widget.url;
    super.initState();
  }

  String url = '';
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  bool isKycPending = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    return Stack(
      children: [
        
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          initialOptions: options,
          onLoadStart: (controller, url) {
            if (url.toString() == '${UrlContainer.domainUrl}/user/deposit/history') {
              Get.offAndToNamed(RouteHelper.coinHistoryScreen);
              CustomSnackBar.success(successList: [MyStrings.requestSuccess.tr]);
            } else if (url.toString() == '${UrlContainer.baseUrl}user/deposit') {
              Get.back();
              CustomSnackBar.error(errorList: [MyStrings.requestFail.tr]);
            }
            setState(() {
              this.url = url.toString();
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(
                  Uri.parse(url),
                );
                return NavigationActionPolicy.CANCEL;
              }
            }
            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            setState(() {
              isLoading = false;
              this.url = url.toString();
            });
          },
          onLoadError: (controller, url, code, message) {},
          onProgressChanged: (controller, progress) {},
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              this.url = url.toString();
            });
          },
          onConsoleMessage: (controller, consoleMessage) {},
        ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: MyColor.primaryColor,
              ))
            : const SizedBox(),
      ],
    );
  }
}
