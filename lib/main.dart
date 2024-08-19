// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/common/theme.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:provider_shopper/screens/cart.dart';
import 'package:provider_shopper/screens/catalog.dart';
import 'package:provider_shopper/screens/category.dart';
import 'package:provider_shopper/screens/login.dart';
import 'package:provider_shopper/screens/register.dart';
import 'package:provider_shopper/screens/wx.dart';
import 'package:window_size/window_size.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

void main() {
  setupWindow();
  //初始化微信SDK
  //fluwx.registerWxApi(appId: "YOUR_WECHAT_APP_ID", doOnAndroid: true, doOnIOS: true);
  FlutterError.onError = (FlutterErrorDetails details) {
    // 处理错误
    print(details.exceptionAsString());
  };

  WidgetsFlutterBinding.ensureInitialized();
  fluwx.registerWxApi(
    appId: "wxf6973a98544b6f48",
    doOnAndroid: true,
    doOnIOS: true,
    // 假设有一个开发模式参数
    //ignoreSignatureCheck: true,
  );

  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
      GoRoute(
        path: '/category',
        builder: (context, state) => const MainCategoryPage(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/wxlogin',
        builder: (context, state) => WxLogin(),
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
