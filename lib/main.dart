import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'first.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: interview("insert"),
  ));
}

class interview extends StatefulWidget {
  String method;
  CategoryList? clist;

  interview(this.method, {this.clist});

  @override
  State<interview> createState() => _interviewState();
}

class _interviewState extends State<interview> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  List<catg> catlistt = [];

  List type = ["Vegetarian", "Non-Vegetarian", "Eggtaria", "Vegan"];

  String cat_type = "", cat_name = "", cat_description = "", cat_qty = "";

  @override
  void initState() {
    if (widget.method == "update") {
      t.text = widget.clist!.catName!;
      t1.text = widget.clist!.catDescription!;
      t2.text = widget.clist!.catQty!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ADD CATGORY"),
          backgroundColor: Colors.grey,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 10,
              margin: EdgeInsets.all(5),
              child: Text(
                '  Name',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
            ),
            Container(
              height: 30,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: t,
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 2),
                ),
              ),
            ),
            Container(
              height: 10,
              margin: EdgeInsets.all(5),
              child: Text(
                '  Type',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
            ),
            Column(
              children: [
                RadioListTile(
                    title: Text(
                      "Vegetarian",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        cat_type = value.toString();
                      });
                    },
                    value: "Vegetarian",
                    groupValue: cat_type),
                RadioListTile(
                    onChanged: (value) {
                      setState(() {
                        cat_type = value.toString();
                      });
                    },
                    title: Text(
                      "Non-Vegetarian",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    value: "Non-Vegetarian",
                    groupValue: cat_type),
                RadioListTile(
                    onChanged: (value) {
                      setState(() {
                        cat_type = value.toString();
                      });
                    },
                    title: Text("Eggtaria"),
                    value: "Eggtaria",
                    groupValue: cat_type),
                RadioListTile(
                    onChanged: (value) {
                      setState(() {
                        cat_type = value.toString();
                      });
                    },
                    title: Text("Vegan"),
                    value: "Vegan",
                    groupValue: cat_type),
              ],
            ),
            Container(
              height: 10,
              margin: EdgeInsets.all(5),
              child: Text(
                '  Descripition',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
            ),
            Container(
              height: 30,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: t1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 2),
                ),
              ),
            ),
            Container(
              height: 10,
              margin: EdgeInsets.all(5),
              child: Text(
                '   Minimum Qty',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
            ),
            Container(
              height: 30,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: t2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(gapPadding: 2),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                cat_name = t.text;
                cat_description = t1.text;
                cat_qty = t2.text;
                var url = Uri.parse("");

                if (widget.method == "insert") {
                  url = Uri.parse(
                      'http://workfordemo.in/bunch1/insert_category.php?cat_type=$cat_type&cat_name=$cat_name&cat_description=$cat_description&cat_qty=$cat_qty');
                } else {
                  url = Uri.parse(
                      'http://workfordemo.in/bunch1/update_category.php?cat_id=${widget.clist!.catId!}&cat_type=$cat_type&cat_name=$cat_name&cat_description=$cat_description&cat_qty=$cat_qty');
                }
                var response = await http.get(url);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                Map m = jsonDecode(response.body);
                if (m['success'] == 1) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return show_cat();
                    },
                  ));
                }
              },
              child: Text("${widget.method}"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return show_cat();
                    },
                  ));
                },
                child: Text("View")),
          ]),
        ));
  }
}

class catg {
  int? success;
  int? catId;
  String? catType;
  String? catName;
  String? catQty;
  String? catDescription;

  catg(
      {this.success,
      this.catId,
      this.catType,
      this.catName,
      this.catQty,
      this.catDescription});

  catg.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    catId = json['cat_id'];
    catType = json['cat_type'];
    catName = json['cat_name'];
    catQty = json['cat_qty'];
    catDescription = json['cat_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['cat_id'] = this.catId;
    data['cat_type'] = this.catType;
    data['cat_name'] = this.catName;
    data['cat_qty'] = this.catQty;
    data['cat_description'] = this.catDescription;
    return data;
  }
}
