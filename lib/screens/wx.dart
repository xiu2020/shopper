import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:http/http.dart' as http;

/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize WeChat SDK
  fluwx.registerWxApi(appId: "wxf6973a98544b6f48", doOnAndroid: true, doOnIOS: false);

  runApp(WxLogin());
}*/

class WxLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '微信扫码登录示例',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WxLoginPage(),
    );
  }
}

class WxLoginPage extends StatelessWidget {
  void loginWithWeChat(BuildContext context) async {
    //bool hasWechat = await fluwx.isWeChatInstalled;
    bool hasWechat = true;
    if (hasWechat) {
      try {
        final result = await fluwx.sendWeChatAuth(
            scope: "snsapi_login", state: "wechat_sdk_demo");

        //&& result.isSuccess
        if (result) {
          // 使用获得的 code 向你的服务器请求 access_token
          //${result.code}
          final response = await http.get(Uri.parse(
              'https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxf6973a98544b6f48&secret=ed71ed99f12db1300face79ef935fbb4&code=200&grant_type=authorization_code'
          ));

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            String accessToken = data['access_token'];
            String openid = data['openid'];

            // 使用 accessToken 和 openid 获取用户信息
            final userInfoResponse = await http.get(Uri.parse(
                'https://api.weixin.qq.com/sns/userinfo?access_token=$accessToken&openid=$openid'
            ));

            if (userInfoResponse.statusCode == 200) {
              final userInfo = jsonDecode(userInfoResponse.body);
              // 显示用户信息
              showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text("用户信息"),
                      content: Text(
                          "昵称: ${userInfo['nickname']}\n头像: ${userInfo['headimgurl']}"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("关闭"),
                        ),
                      ],
                    ),
              );
            } else {
              print("获取用户信息失败: ${userInfoResponse.body}");
            }
          } else {
            print("获取 access_token 失败: ${response.body}");
          }
        }
      } catch (e) {
        print("Exception during WeChat login: $e");
      }
    } else {
        print("未安装webchat");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信扫码登录示例'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => loginWithWeChat(context),
          child: Text('使用微信扫码登录'),
        ),
      ),
    );
  }
}