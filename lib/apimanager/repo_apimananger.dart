

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:task1/common/constants.dart';
import 'package:task1/models/items.dart';

class RepoApiManager{

  Future<ItemObj> getRepositories(String date) async {
    late ItemObj data;
      final response = await get(
        Uri.parse(Constants.baseurl(date)),
      );
      if (response.statusCode == 200||response.statusCode == 201) {
        final item = json.decode(response.body);
        data = ItemObj.fromJson(item);
      } else {
        if (kDebugMode) {
          print('Error Occurred');
        }
      }
    return data;
  }

}