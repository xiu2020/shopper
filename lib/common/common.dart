import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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