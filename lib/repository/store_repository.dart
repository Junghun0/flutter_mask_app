import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:maskapp/model/store.dart';

class StoreRepository {

  Future<List<Store>> fetch() async {
    final stores = List<Store>();
//    setState(() {
//      isLoading = true;
//    });

    var url =
        'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=37.266389&lng=126.999333&m=1000';
    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

//    setState(() {
//      if (stores.isNotEmpty) {
//      }
      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });
//      isLoading = false;
//    });
  return stores;
  }
}