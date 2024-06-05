import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import 'httpUtil.dart';

Future<void> showCustomAlertDialog(BuildContext context, String name, String desc) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(name),
        content: Text(desc),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
          /*TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Confirm'),
          ),*/
        ],
      );
    },
  );
  return;
}

Future<void> showNormalDialog(BuildContext context, String text, String location) async {
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
              if (location.length > 0) {
                context.go(location);
              }
            },
          ),

          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  return;
}

Future<void> useSnackBar(BuildContext context, String text, String type) async {
  var color;
  color = Colors.red;
  if (type == "info") {
    color = Colors.blue;
  } else if (type == "warn") {
    color = Colors.orange;
  }
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
        backgroundColor:  color,
      )
  );
}

Future<void> showCommonDialog(BuildContext context, String text) async {
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

Future<void> _showDialogSuccess(BuildContext context, String text) async {
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

//http://172.24.110.18:2000/client/test
Future<String> GetData(String uri, Map<String, String> body, String method) async {
  ApiManager apiManager = ApiManager();
  var url = apiManager.getBaseUrl() + uri;
  Map<String, String> headers = {'content-type': 'application/json'};
  //Map<String, String> body = {'username': username, 'password': password};
  var encodedBody = jsonEncode(body);

  // 发送 POST 请求
  int? responseCode = -1;
  String message = "";
  try {
    Response response;
    if(method == "post") {
      response = await apiManager.post(url, data: body);
    } else {
      response = await apiManager.get(url, data: body);
    }

    //print(response); // 处理响应数据
    //print(response.data["data"]); // 处理响应数据
    responseCode = response.statusCode;
    message = response.data["data"];

    //var response = await http.post(url, headers: headers, body: encodedBody);
    if (responseCode == 200) {
        return message;
    }
  } catch (e) {
    print('Error occurred: $e');
  }

  return "";
}

Future<void> handleJsonSample(String jsonStr) async {
  String jsonString = '''
  {
    "name": "John Doe",
    "age": 30,
    "email": "johndoe@example.com",
    "address": {
      "street": "123 Main Street",
      "city": "Anytown"
    },
    "friends": ["Alice", "Bob", "Charlie"]
  }
  ''';

  Map<String, dynamic> jsonData = json.decode(jsonString);

  print('Name: ${jsonData['name']}');
  print('Age: ${jsonData['age']}');
  print('Email: ${jsonData['email']}');

  Map<String, dynamic> address = jsonData['address'];
  print('Address: ${address['street']}, ${address['city']}');

  List<dynamic> friends = jsonData['friends'];
  print('Friends:');
  for (var friend in friends) {
    print(friend);
  }
}