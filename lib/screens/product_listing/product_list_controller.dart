import 'package:commerce_project/api/api_service.dart';
import 'package:commerce_project/api/database_helper.dart';
import 'package:commerce_project/model/product_list_model.dart';
import 'package:commerce_project/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListController extends GetxController {
  RxList<ProductListModel> products = <ProductListModel>[].obs;
  RxBool isLoading = true.obs;
  final selectedProduct = ProductListModel().obs;
  late SharedPreferences prefs;

  @override
  void onInit() {
    fetchProducts();
    initSharedPreferences();
    super.onInit();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void logout(BuildContext context) {
    // Clear stored user session
    DatabaseHelper.instance.clearLoggedInUser();
    Get.offAll(() => LoginScreen());
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var productList = await ProductService().fetchProducts();
      if (productList != null) {
        productList.forEach((product) {
          product.isFavorite.value =
              prefs.getBool('${product.id}_favorite') ?? false;
        });
        products.assignAll(productList);
      }
    } finally {
      isLoading(false);
    }
  }

  void selectProduct(int index) {
    selectedProduct.value = products[index];
  }

  void toggleFavoriteStatus(ProductListModel product) {
    product.isFavorite.value = !product.isFavorite.value;
    prefs.setBool('${product.id}_favorite', product.isFavorite.value);
    update();
  }
}
