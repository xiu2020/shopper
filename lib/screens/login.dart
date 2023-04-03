// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _showDialog(String text) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogSuccess(String text) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
                context.pushReplacement('/catalog');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> login(String username, String password) async {
    var url = Uri.parse('http://localhost:2000/client/test');
    Map<String, String> headers = {'content-type': 'application/json'};
    Map<String, String> body = {'username': username, 'password': password};
    var encodedBody = jsonEncode(body);
    var response = await http.post(url, headers: headers, body: encodedBody);
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      var message = decodedJson['msg'];
      if (message == 'success' || message == 'Success') {
        await _showDialogSuccess('登录成功1');
      } else {
        await _showDialog('登录失败，请检查用户名和密码是否正确');
      }
    } else {
      await _showDialog('网络错误，请稍后再试！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                  labelText: '用户名',
                  icon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.text,
                controller: userController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '密码',
                  hintText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: passwordController,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  var username = userController.text;
                  var password = passwordController.text;
                  login(username, password);
                  //context.pushReplacement('/catalog');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: const Text('ENTER'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
