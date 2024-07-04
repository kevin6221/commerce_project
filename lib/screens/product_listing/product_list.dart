import 'package:commerce_project/screens/profile/profile.dart';
import 'package:commerce_project/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:commerce_project/screens/product_details/product_details.dart';
import 'package:commerce_project/screens/product_listing/product_list_controller.dart';

class ProductScreen extends StatelessWidget {
  final ProductListController productListController =
      Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                productListController.logout(context);
              } else if (value == 'profile') {
                Get.to(ProfileScreen());
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'profile',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (productListController.isLoading.value) {
              return buildShimmerList();
            } else {
              return ListView.builder(
                itemCount: productListController.products.length,
                itemBuilder: (context, index) {
                  var product = productListController.products[index];
                  return InkWell(
                    onTap: () {
                      productListController.selectProduct(index);
                      Get.to(ProductDetail());
                    },
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  product.images![0],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 50,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const commonSizeBox(width: 10),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const commonSizeBox(height: 5),
                                  Text(
                                    '\$${product.price!.toString()}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const commonSizeBox(height: 5),
                                ],
                              ),
                            ),
                            const commonSizeBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Obx(() => product.isFavorite.value
                                    ? Icon(Icons.favorite, color: Colors.red)
                                    : Icon(Icons.favorite_border)),
                                onPressed: () {
                                  productListController
                                      .toggleFavoriteStatus(product);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
