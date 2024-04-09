import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemsListApp extends StatelessWidget {
  final String url;

  ItemsListApp({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items List'),
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListTile(
              title: Text('Items List'),
              onTap: () {},
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<Item>> fetchItems() async {
    var url = Uri.parse('http://localhost:2000/client/test');
    Map<String, String> headers = {'content-type': 'application/json'};
    Map<String, String> body = {};
    var encodedBody = jsonEncode(body);
    var response = await http.get(url, headers: headers, body: encodedBody);
    return json.decode(response.data);
  }
}

class Item {
  String name;
  String description;
  String img_path;

  Item({this.name, this.description, this.img_path});

  constructor() {
    super();
  }
}
