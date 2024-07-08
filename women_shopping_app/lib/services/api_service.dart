// api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchProducts() async {
  final response = await http.get(Uri.parse(
      'https://api.timbu.cloud/products?organization_id=1ef4103932044fecbf1d91bfb2dfeb82&reverse_sort=false&page=1&size=10&Appid=LPCX39LV32BJNCY&Apikey=bf396669c56d4d0b892691a11b55ea6e20240706232745569668'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load products');
  }
}
