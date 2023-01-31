import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class show_cat extends StatefulWidget {
  const show_cat({Key? key}) : super(key: key);

  @override
  State<show_cat> createState() => _show_catState();
}

class _show_catState extends State<show_cat> {
  List<CategoryList> data = [];
  List<Map> list = [];

  getdata() async {
    var url = Uri.parse('http://workfordemo.in/bunch1/get_category.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String, dynamic> m = jsonDecode(response.body);
    int_cat cat = int_cat.fromJson(m);
    setState(() {
      data = cat.categoryList!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Category")),
      body: data.length > 0
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                CategoryList clist = data[index];
                print(clist);
                return ListTile(
                  title: Text("${clist.catName}"),
                  subtitle: Text("${clist.catDescription}"),
                  leading: Container(
                    child:
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  ),
                  // Text("${clist.catQty}"),
                  trailing: Container(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return interview(
                                "update",
                                clist: clist,
                              );
                            },
                          ));
                        },
                        icon: Icon(Icons.edit)),
                  ),
                );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}

class int_cat {
  int? success;
  List<CategoryList>? categoryList;

  int_cat({this.success, this.categoryList});

  int_cat.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? catId;
  String? catName;
  String? catQty;
  String? catDescription;
  String? catCreated;

  CategoryList(
      {this.catId,
      this.catName,
      this.catQty,
      this.catDescription,
      this.catCreated});

  CategoryList.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catQty = json['cat_qty'];
    catDescription = json['cat_description'];
    catCreated = json['cat_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_qty'] = this.catQty;
    data['cat_description'] = this.catDescription;
    data['cat_created'] = this.catCreated;
    return data;
  }

  @override
  String toString() {
    return 'CategoryList{catId: $catId, catName: $catName, catQty: $catQty, catDescription: $catDescription, catCreated: $catCreated}';
  }
}
