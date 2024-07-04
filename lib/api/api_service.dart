// product_service.dart
import 'dart:convert';
import 'package:commerce_project/api/api_const.dart';
import 'package:commerce_project/model/product_list_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductListModel>> fetchProducts() async {
    const url = URLConst.base_url + URLConst.productList;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      List<ProductListModel> products = jsonResponse
          .map((model) => ProductListModel.fromJson(model))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
