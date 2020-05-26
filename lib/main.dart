import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stores = List<Store>();

  Future fetch() async {
    var url =
        'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=37.266389&lng=126.999333&m=1000';
    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

    setState(() {
      if (stores.isNotEmpty) {
        stores.clear();
      }
      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳 : 0 곳'),
        ),
        body: ListView(
          children: stores.map((e) {
            return ListTile(
              title: Text(e.name),
              subtitle: Text(e.addr),
              trailing: Text(e.remainStat ?? '매진'),
            );
          }).toList(),
        ));
  }
}
