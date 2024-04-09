// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// A proxy of the catalog of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the catalog is procedurally generated and infinite.
///
/// For simplicity, the catalog is expected to be immutable (no products are
/// expected to be added, removed or changed during the execution of the app).
class CatalogModel {
  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) {
    for(var item in customItemList) {
      if (item.id == id) {
        return Item(item.id, item.name, item.image, item.desc, item.price);
      }
    }
    return Item(0, "0", "0", "", 0);
  }

  /// Get item by its position in the catalog.
  Item getByPosition(int id) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(id);
  }
}

List<Item> customItemList = [
  Item(1, 'Item 1', "assets/images/Icon-192.png", "desc1 desc desc desc desc desc1 desc desc desc desc desc1 desc desc desc desc...", 1),
  Item(2, 'Item 2', "assets/images/bw.png", "desc2 desc desc desc desc...", 2),
  Item(3, 'Item 3', "assets/images/bw.png", "desc3 desc desc desc desc...", 3),
  Item(4, 'Item 4', "assets/images/bw.png", "desc1 desc desc desc desc...", 4),
  Item(5, 'Item 5', "assets/images/bw.png", "desc2 desc desc desc desc...", 5),
  Item(6, 'Item 6', "assets/images/bw.png", "desc3 desc desc desc desc...", 6),
  Item(7, 'Item 7', "assets/images/bw.png", "desc1 desc desc desc desc...", 7),
  Item(8, 'Item 8', "assets/images/bw.png", "desc2 desc desc desc desc...", 8),
  Item(9, 'Item 9', "assets/images/bw.png", "desc3 desc desc desc desc...", 9),
  Item(10, 'Item 10', "assets/images/bw.png", "desc1 desc desc desc desc...", 10),
  Item(11, 'Item 11', "assets/images/bw.png", "desc2 desc desc desc desc...", 11),
  Item(12, 'Item 12', "assets/images/bw.png", "desc3 desc desc desc desc...", 12),
  Item(13, 'Item 13', "assets/images/bw.png", "desc1 desc desc desc desc...", 13),
  Item(14, 'Item 14', "assets/images/bw.png", "desc2 desc desc desc desc...", 14),
  Item(15, 'Item 15', "assets/images/bw.png", "desc3 desc desc desc desc...", 15),
  // 添加更多的自定义 Item 对象
];

@immutable
class Item {
  final int id;
  final String name;
  final String image;
  final String desc;
  double price = 42;

  Item(this.id, this.name, this.image, this.desc, this.price){}
  /*Item(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      //: color = Colors.primaries[id % Colors.primaries.length];
      : color = customItemList[id % customItemList.length].color;
*/
  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
