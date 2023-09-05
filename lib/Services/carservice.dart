import 'dart:convert';

import 'package:exam/models/carmodel.dart';
import 'package:flutter/services.dart';

class Cardataservice {
  Future<List<CarModel>> carlist() async {
    List<CarModel> carlist = [];
    var jsondata = await rootBundle.loadString("Json_File/cardata.json");
    var list = jsonDecode(jsondata);
    for (var i = 0; i < list.length; i++) {
      carlist.add(CarModel.fromJson(list[i]));
    }
    return carlist;
  }
}
