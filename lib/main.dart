import 'package:flutter/material.dart';

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
  var isLoading = true;


  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '마스크 재고 있는 곳 : ${stores.where((e) => e.remainStat == 'plenty' || e.remainStat == 'some' || e.remainStat == 'few').length} 곳'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                fetch();
              },
            )
          ],
        ),
        body: isLoading
            ? loadingWidget()
            : ListView(
                children: stores
                    .where((e) =>
                        e.remainStat == 'plenty' ||
                        e.remainStat == 'some' ||
                        e.remainStat == 'few')
                    .map((e) {
                  return ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.addr),
                    trailing: _buildRemainStateWidget(e),
                  );
                }).toList(),
              ));
  }

  Widget _buildRemainStateWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30-100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2-30개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '매진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: <Widget>[
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '정보를 가져오는 중',
              style: TextStyle(fontSize: 15),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
