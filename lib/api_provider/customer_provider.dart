import 'dart:convert';
import 'package:customer/core/constant.dart';
import 'package:customer/models/customer_model.dart';
import 'package:http/http.dart' as http;

class CustomerProvider {
  Future<CustomerModel> fetchCustomer() async {
    final response = await http.get(Uri.parse('${AppUrls.newsAPIBaseURL}/listview'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return CustomerModel.fromJson(jsonData['users']);

    } else {
      throw Exception('Failed to fetch data');
    }
  }
}