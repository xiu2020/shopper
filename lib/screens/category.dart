import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'buttom.dart';
import 'package:provider_shopper/common/common.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/catalog.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

Map<String, CategoryItems> categoryItems = {};

class _CategoryPageState extends State<MainCategoryPage> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final jsonString = await GetData("/client/test", {}, "get");
    /*if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        categories = data.map((item) => item['name'].toString()).toList();
      });
    } else {
      throw Exception('Failed to load categories');
    }*/
    List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      categories = jsonData.map((item) => item['name'].toString()).toList();
      for(var category in jsonData) {
        List<Item>Items = [];
        for(var item in category["item"]) {
          Item newItem = Item(
              item["id"],
              item["name"],
              item["image"],
              item["desc"],
              item["price"].toDouble());
          Items.add(newItem);
        }
        categoryItems[category['name']] = CategoryItems(category['id'], category['name'], Items);
      }

      /*categoryItems.forEach((key, value) {
        print(value.items);
        for(var v in value.items) {
          print(v.name);
        }
      });*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类页面'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPage(category: categories[index]),
                ),
              );
            },
            child: ListTile(
              title: Text(categories[index]),
              //subtitle: Text('加载中...'),
              subtitle: Column(
                children: [
                  _MyListItem(index),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String category;

  CategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category 商品页面'),
      ),
      body: Center(
        child: Text('加载中...'),
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);


  @override
  Widget build(BuildContext context) {
    if (index >= categoryItems.length) {
      return Container(); // 返回一个空的容器或者其他适当的占位符
    }

    var item = context.select<CatalogModel, CategoryItems>(
      // Here, we are only interested in the item at [index]. We don't care
      // about any other change.
          (catalog) => catalog.getCategoryItemByPosition(index, categoryItems[index]!),
    );
    var textTheme = Theme.of(context).textTheme.titleSmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () async {
          await showCustomAlertDialog(context, item.name, item.items[0].desc);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50, // 设置图片容器的宽度
              height: 50, // 设置图片容器的高度
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item.items[0].image), // 替换为您的图片路径
                  fit: BoxFit.cover, // 根据需要调整图片填充方式
                ),
              ),
            ),
            const SizedBox(width: 24), // 调整图片和描述之间的间距
            Expanded(
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: textTheme),
                    Text(
                      item.items[0].desc,
                      style: TextStyle(color: Colors.grey),
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            ),
           // _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
