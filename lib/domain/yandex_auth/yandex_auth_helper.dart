import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:monarchium/domain/yandex_auth/yandex_auth_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class YandexAuthHelper {
  static const String scheme = "monarchium://token";
  static const String _clientId = "c611bd6da5724efbab2dc2377a6ce433";
  static const String _redirectUri = "monarchium://token";
  // static const String _debugToken =
  //     'y0_AgAAAAA3WH8DAAjkGgAAAADXJWJa1ywPRaRlQYyZtR7Ec4eluxIABGo';
  static const String _responseType = "token";
  static final Uri _uri = Uri.parse(
    "https://oauth.yandex.ru/authorize?response_type=$_responseType&client_id=$_clientId&redirect_uri=$_redirectUri&display=popup",
  );

  WebViewController webViewController({
    required void Function(String)? onPageFinished,
    required FutureOr<NavigationDecision> Function(NavigationRequest)?
        onNavigationRequest,
  }) {
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
  }

  Future oauthCode() async {
    // Change response type to "code"

    await launchUrl(
      _uri,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: WebViewConfiguration(enableJavaScript: true),
    );
  }

  Future<YandexAuthData> getCurrentUser(YandexTokenData tokenData) async {
    http.Response response = await http.get(
      Uri.parse('https://login.yandex.ru/info?format=json'),
      headers: {
        'Authorization': "OAuth ${tokenData.accessToken}",
      },
    );
    log(response.body);

    return YandexAuthData.fromJson(response.body);
  }
}

class YandexTokenData {
  YandexTokenData({
    this.accessToken,
    this.expiresIn,
    this.error,
    this.state,
  });

  final String? accessToken;
  final DateTime? expiresIn;
  final String? error;
  final String? state;

  static fromStringUrl(String link) {
    final decoded = Uri.decodeFull(link).replaceAll('#', '?');
    Uri uri = Uri.parse(decoded);

    String? error = uri.queryParameters['error'];
    String? state = uri.queryParameters['state'];
    if (error != null) return YandexTokenData(error: error, state: state);

    String? accessToken = uri.queryParameters['access_token'];
    String? expiresInString = uri.queryParameters['expires_in'];
    DateTime? expiresIn = expiresInString != null
        ? DateTime.now().add(Duration(seconds: int.parse(expiresInString)))
        : null;

    return YandexTokenData(
      accessToken: accessToken,
      expiresIn: expiresIn,
    );
  }

  @override
  String toString() {
    if (error != null && error!.isNotEmpty)
      return "YandexTokenData(error: $error, state: $state)";
    return "YandexTokenData(accessToken: $accessToken, expiresIn: $expiresIn)";
  }
}
