import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class OKAuthHelper {
  static const String clientId = '512001611855';
  static const String scheme = 'okauth://ok512001611855';
  static const String _applicationPublicKey = 'CQEJJNKGDIHBABABA';
  // static const String _accessToken =
  //     'tkn1IvV6HGtZ4jr0U72CBwxptitrlTjpvp6zO8kHT2oSNcIhL2vibBrZvV8RY0Zy00QEP';
  // static const String _sessionSecretKey = '21531ce4f7110151d7ffef6be8ba4c1c';
  static const String _scope =
      'VALUABLE_ACCESS; GET_EMAIL; PHOTO_CONTENT; LONG_ACCESS_TOKEN;';
  static const String _responseType = "token";
  static const String _layout = "* m";

  static String get _redirectUri {
    if (GetPlatform.isIOS) return 'ok512001611855://authorize';
    if (GetPlatform.isAndroid) return 'okauth://ok512001611855';
    return '';
  }

  static final Uri _uri = Uri.parse(
      'https://connect.ok.ru/oauth/authorize?client_id=$clientId&scope=$_scope&response_type=$_responseType&redirect_uri=$_redirectUri&layout=$_layout');

  WebViewController webViewController({
    required void Function(String)? onPageFinished,
    required FutureOr<NavigationDecision> Function(NavigationRequest)?
        onNavigationRequest,
  }) {
    // http.Response response = await http.get(uri);

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (int progress) {
          //   // Update loading bar.

          // },
          onPageStarted: (String url) {},
          onPageFinished: onPageFinished,
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: onNavigationRequest,
        ),
      )
      ..loadRequest(_uri);

    return controller;

    // await launchUrl(
    //   uri,
    //   mode: LaunchMode.inAppWebView,
    //   webViewConfiguration: WebViewConfiguration(enableJavaScript: true),
    // );
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future getCurrentUser(OKTokenData okAuthData) async {
    String scope =
        "FIRST_NAME, LAST_NAME, PIC_1, EMAIL, BIRTHDAY, CITY_OF_BIRTH, HAS_PHONE";
    String glued =
        "application_key=${_applicationPublicKey}fields=${scope}format=jsonmethod=users.getCurrentUser${okAuthData.sessionSecretKey}";

    String sig = generateMd5(glued);
    Uri uri = Uri.parse(
        'https://api.ok.ru/fb.do?application_key=$_applicationPublicKey&fields=$scope&format=json&method=users.getCurrentUser&sig=$sig&access_token=${okAuthData.accessToken}');
    http.Response response = await http.get(uri);

    printInfo(info: response.body);
    return jsonDecode(response.body);
  }
}

class OKTokenData {
  OKTokenData({
    this.accessToken,
    this.sessionSecretKey,
    this.error,
    this.state,
  });

  final String? accessToken;
  final String? sessionSecretKey;
  final String? error;
  final String? state;

  static fromStringUrl(String link) {
    final decoded = Uri.decodeFull(link).replaceAll('#', '?');
    Uri uri = Uri.parse(decoded);

    String? error = uri.queryParameters['error'];
    if (error != null) return OKTokenData(error: error);

    String? accessToken = uri.queryParameters['access_token'];
    String? sessionSecretKey = uri.queryParameters['session_secret_key'];

    return OKTokenData(
        accessToken: accessToken, sessionSecretKey: sessionSecretKey);
  }

  // bool get hasError => this.error == null;
}
