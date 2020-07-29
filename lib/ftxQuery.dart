
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ftxQueryClasses.dart';


const String apiEndpoint = "https://ftx.com/api/expired_futures";


Future<ExpiredFutures> fetchExpiredContractsData() async {
  var response = await http.get(apiEndpoint);

  if (response.statusCode == 200) {
    return ExpiredFutures.fromJson(json.decode(response.body));

  } else {
    throw Exception("Failed to fetch Expired Contracts Data");
  }
}
