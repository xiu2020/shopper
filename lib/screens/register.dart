import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider_shopper/common/httpUtil.dart';
import 'package:provider_shopper/common/common.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> register(BuildContext context, String username, String password) async {
    // 在这里实现注册逻辑
    // 例如，发送 POST 请求到注册 API
    print('Registering user: $username');
    // 实际的注册逻辑需要根据你的 API 来实现
    Map<String, String> headers = {'content-type': 'application/json'};
    Map<String, String> body = {'username': username, 'password': password};
    var encodedBody = jsonEncode(body);

    ApiManager apiManager = ApiManager();
    int? responseCode = -1;
    String message = "";
    try {
      Response response = await apiManager.post(apiManager.getBaseUrl() + "/client/test", data: body);
      print(response); // 处理响应数据
      responseCode = response.statusCode;
      message = response.data["msg"];

      //var response = await http.post(url, headers: headers, body: encodedBody);
      if (responseCode == 200) {
        //var decodedJson = jsonDecode(responseData);
        //var message = decodedJson['msg'];
        if (message == 'success' || message == 'Success') {
          context.go('/login');
        } else {
          await showCommonDialog(context,'登录失败，请检查用户名和密码是否正确');
        }
      } else {
        await showCommonDialog(context, '网络错误，请稍后再试！');
      }
    } catch (e) {
      print('Error occurred: $e');
      await useSnackBar(context, '网络错误，请稍后再试！', "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '注册',
                style: Theme.of(context).textTheme.headline4,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '手机号码',
                  labelText: '手机号码',
                  icon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.text,
                controller: usernameController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '密码',
                  hintText: '密码',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: passwordController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '确认密码',
                  hintText: '确认密码',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  var username = usernameController.text;
                  var password = passwordController.text;
                  var confirmPassword = confirmPasswordController.text;

                  if (password == confirmPassword) {
                    register(context, username, password);
                  } else {
                    showCommonDialog(context, '密码不匹配，请重新输入');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('注册'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}