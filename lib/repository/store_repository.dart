import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:maskapp/model/store.dart';

class StoreRepository {

  Future<List<Store>> fetch(double lat, double lng) async {
    final stores = List<Store>();

    var url =
        'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=$lat&lng=$lng&m=1000';
    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });

  return stores.where((e) =>
  e.remainStat == 'plenty' ||
      e.remainStat == 'some' ||
      e.remainStat == 'few').toList();
  }
}